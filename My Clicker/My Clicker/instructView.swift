//
//  instructView(1).swift
//  My Clicker
//
//  Created by 세린맥북 on 6/18/24.
//

import SwiftUI

//@State var addViewSheet = false

struct customIndicator: View {
    var numberOfPages: Int
    var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.gray : Color.lightGray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 8)
    }
}

struct instructView: View {
    
    @State private var selectedPage = 0
    @State private var isSheetPresented = false
    
    var body: some View {
        
        VStack(alignment:.leading){
            
            Button(action: {
                isSheetPresented.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.basicGreen)
                    .frame(width: 16, height: 16)
                    .padding(.leading,355)
            }
            .sheet(isPresented: $isSheetPresented){
                addSheet()
                    .presentationDragIndicator(.visible)
                
            }
            
            
            VStack(alignment:.leading){
                VStack(alignment:.leading){
                    Text("MY Clicker!")
                        .font(.system(size:20))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.basicGreen)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                    
                    Text("연결에 성공하였습니다!")
                        .font(.system(size:30))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    //                        .padding(.bottom,52)
                }
                .padding(.leading,20)
                
                
                ZStack{
                    Image("phoneFrame")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 236, height: 417)
                        .padding(.leading,40)
                        .padding(.top, 30)
                        .padding(.bottom, 120)
                    Spacer()
                        .frame(height: 300)
                    
                    TabView (selection: $selectedPage) {
                        VStack{
                            Image("redAlram")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .padding(.bottom,175)
                            
                            Text("01 알림 소리")
                                .font(.system(size:20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 10)
                            
                            Text("마이클리커를 1 번 누르면\niPhone에서 알림 소리가 재생됩니다.")
                                .font(.system(size:14))
                                .foregroundColor(.lightGray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,50)
                        .tag(0)
                        
                        VStack{
                            Image("yellowSplash")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 190, height: 190)
                                .padding(.bottom, 145)
                            
                            Text("02 반짝반짝 플래쉬")
                                .font(.system(size:20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 10)
                            
                            Text("마이클리커를 2 번 누르면\niPhone의 플래쉬도 반응하게 됩니다.")
                                .font(.system(size:14))
                                .foregroundColor(.lightGray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,50)
                        .tag(1)
                        
                        VStack{
                            Image("greenVibration")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 190, height: 190)
                                .padding(.bottom, 145)
                            
                            Text("03 진동소리")
                                .font(.system(size:20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 10)
                            
                            
                            Text("마이클리커를 3 번 눌러주면\niPhone에서 진동도 함께 울리게 됩니다.")
                                .font(.system(size:14))
                                .foregroundColor(.lightGray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,50)
                        .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .padding(.top, 112)
                    .frame(width: 350, height: 580)
                    
                    
                    
                }
                
            }
        }
        .padding (.top, 75)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        customIndicator(numberOfPages: 3, currentPage: selectedPage)
            .padding(.bottom, 80)
        
            .navigationBarBackButtonHidden(true)
        
    }
}




#Preview {
    instructView()
}
