//
//  HomeView.swift
//  SampleCountUp
//
//  Created by 久富稜也 on 2021/03/25.
//

import SwiftUI

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
                        .trim(from: 0, to: 0.5)
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
        //指定した時間（1秒）ごとに発動するtimerをトリガーにしてクロージャ内のコードを実行
        .onReceive(self.time, perform: { _ in
            print("Hello")
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
