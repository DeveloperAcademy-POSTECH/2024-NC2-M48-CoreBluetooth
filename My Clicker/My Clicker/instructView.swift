//
//  instructView(1).swift
//  My Clicker
//
//  Created by 세린맥북 on 6/18/24.
//

import SwiftUI

struct instructView: View {
    var body: some View {
        VStack(alignment:.leading){
            Image(systemName: "plus")
                .foregroundColor(.basicGreen)
                .frame(width: 16, height: 16)
                .padding(.leading,355)
            
            VStack(alignment:.leading){
                VStack(alignment:.leading){
                    Text("MY Clicker!")
                        .font(.system(size:20))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.basicGreen)

                    
                    Text("연결에 성공하였습니다!")
                        .font(.system(size:30))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom,52)
                }
                .padding(.leading,20)
                
                ZStack{
                    Image("phoneFrame")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 176, height: 357)
                        .padding(.leading,130)
                    Image("redAlram")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 162)
                        .padding(.leading,100)
                        .padding(.bottom,104)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                
                VStack{
                    Text("01 알림 소리")
                        .font(.system(size:20))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom,17)
                    
                    Text("마이클리커를 1 번 누르면\niPhone에서 알림 소리가 재생됩니다.")
                        .font(.system(size:14))
                        .foregroundColor(.lightGray)
                        .multilineTextAlignment(.center)
                }
                .padding(.leading,88)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    instructView_1_()
}
