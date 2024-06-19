//
//  ContentView.swift
//  My Clicker
//
//  Created by Jeho Ahn on 6/17/24.
//

import SwiftUI

struct mainVeiw: View {
    var body: some View {
        
        NavigationView {
            ZStack(alignment:.top){
                Color.backgroundGreen.edgesIgnoringSafeArea(.all)
                
                    VStack{
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 393, height: 477)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                                .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 7)
                            VStack(alignment:.leading){
                                Text("나의 아이폰 찾기")
                                    .foregroundColor(.basicGreen)
                                    .font(.system(size:20))
                                    .fontWeight(.bold)
                                //                                .padding(.bottom,5)
                                Text("MY Clicker")
                                    .fontWeight(.bold)
                                    .font(.system(size:50))
                                    .padding(.bottom, 5)
                                
                                Text("마이 클리커를 통해 애플워치 없이도\n블루투스 연결을 이용하여\n한번에 당신의 아이폰 위치를 찾아보세요!")
                                    .font(.system(size:14))
                                    .lineSpacing(6)
                                    .padding(.bottom, 143)
                                
                                
                                NavigationLink(destination:
                                                deviceConnect()){
                                    HStack{
                                        Text("연결하기")
                                            .font(.system(size:14))
                                            .fontWeight(.bold)
                                        Image(systemName: "arrow.up.forward")
                                    }
                                    .foregroundColor(.black)
                                    .padding(.leading, 16)
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.top, 63)
                            
                        }
                        Image("mainGraphic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 353, height: 330)
                            .padding(20)
                            .padding(.bottom, 30)
                    }
                }

            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
}

#Preview {
    mainVeiw()
}
