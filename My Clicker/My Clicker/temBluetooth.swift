//
//  temBluetooth.swift
//  My Clicker
//
//  Created by 세린맥북 on 6/20/24.
//

import SwiftUI

struct temBluetooth: View {
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .leading){
                Text("MY Clicker!")
                    .foregroundColor(.basicGreen)
                    .font(.system(size:20))
                    .fontWeight(.bold)
                Text("Bluetooth 연결하기")
                    .font(.system(size:30))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("MY DEVICES")
                    .font(.system(size:14))
                
                Spacer()
                    .frame(height: 100)
                
                Text("확인")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 0)
                    .padding([.vertical], 18)
                    .padding([.horizontal],161)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.lightGray)
                    }
                NavigationLink(destination: instructView()){
                    Text("확인")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 0)
                        .padding([.vertical], 18)
                        .padding([.horizontal],161)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.basicGreen)
                        }
                }
            }
        }

        
        
        
        
        
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    temBluetooth()
}
