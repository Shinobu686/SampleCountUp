//
//  HomeView.swift
//  SampleCountUp
//
//  Created by 久富稜也 on 2021/03/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            
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
                    Text("15")
                        .font(.system(size: 65))
                        .fontWeight(.bold)
                    Text("of 15")
                        .font(.title)
                        .padding()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
