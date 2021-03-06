//
//  HomeView.swift
//  SampleCountUp
//
//  Created by 久富稜也 on 2021/03/25.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    
    @State var start = false
    @State var to: CGFloat = 0
    @State var count = 0
    
    //1秒ごとに発動するTimerクラスのpublishメソッド
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                        .rotationEffect((.init(degrees: -90)))
                    
                    VStack{
                        Text("\(self.count)")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                        Text("of 15")
                            .font(.title)
                            .padding()
                    }
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        //スタート・ストップ処理
                        self.start.toggle()
                    }) {
                        HStack(spacing: 20) {
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                            Text(self.start ? "pause" : "play")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    Button(action: {
                        //リスタート処理
                        self.count = 0
                        withAnimation(.default) {
                            self.to = 0
                        }
                    }) {
                        HStack(spacing: 20) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.red)
                            Text("Restart")
                                .foregroundColor(.red)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(
                            Capsule()
                                .stroke(Color.red, lineWidth: 2)
                        ).shadow(radius: 6)
                    }
                }.padding(.top, 55)
            }
        }
        
        .onAppear(perform: { //プッシュ通知の許可を求めるダイアログ表示
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in
            }
        })
        //指定した時間（1秒）ごとに発動するtimerをトリガーにしてクロージャ内のコードを実行
        .onReceive(self.time) { _ in
            
            if self.start {
                
                if self.count != 15 {
                    self.count += 1
                    print("Hello")
                    withAnimation(.default) {
                        self.to = CGFloat(self.count) / 15
                    }
                } else { //15になったらストップ
                    self.start.toggle()
                    self.makeNotification()
                }
            }
        }
    }
    
    //通知関係のメソッド
    func makeNotification() {
        
        //通知タイミングを指定
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        //通知コンテンツの作成
        let content = UNMutableNotificationContent()
        content.title = "メッセージ"
        content.body = "タイマーが終了しました！"
        
        //通知タイミングと通知内容をまとめてリクエストを作成
        let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)
        
        //リクエスト通りに通知を実行させる
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
