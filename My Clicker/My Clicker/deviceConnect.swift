//
//  deviceConnect.swift
//  My Clicker
//
//  Created by 세린맥북 on 6/18/24.
//

import SwiftUI

struct deviceConnect: View {
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            VStack(alignment:.leading){
                Text("나의 아이폰 찾기")
                    .foregroundColor(.basicGreen)
                    .font(.system(size:20))
                    .fontWeight(.bold)
                //                    .padding(.bottom,12)
                    .padding(.top, 32)
                Text("MY Clicker")
                    .fontWeight(.bold)
                    .font(.system(size:50))
                    .padding(.bottom, 5)
                
                Text("마이 클리커를 통해 기기를\n제어하려면\n휴대폰 블루투스를 켜야해요")
                    .fontWeight(.bold)
                    .font(.system(size:14))
                    .lineSpacing(6)
            }
            .padding(.leading, 20)
            
            HStack {
                Spacer()
                Image("clickerDevice")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 126, height: 236)
                Spacer()
            }
            .padding(.top, 118)
            .padding(.bottom, 99)
            NavigationLink(destination: temBluetooth()){
                Text("켜러가기")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 0)
                    .padding([.vertical], 18)
                    .padding([.horizontal],148)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.basicGreen)
                    }
                    .padding(.bottom, 30)
            }
            .padding(.leading, 18)
            //                .padding(.bottom, 43)
        }
        
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        
    }
}


#Preview {
    deviceConnect()
}
