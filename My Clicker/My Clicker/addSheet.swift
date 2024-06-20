//
//  addViewSheet.swift
//  My Clicker
//
//  Created by 세린맥북 on 6/20/24.
//

import SwiftUI

struct addSheet: View {
    var body: some View {
        ScrollView {
            VStack(alignment:.leading){
                Text("My Clicker의\n동작을 설정하여\niPhone을 제어해보세요!")
                    .fontWeight(.bold)
                    .font(.system(size:20))
                    .lineSpacing(6)
                Image("addViewImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width:356, height: 700)
                
            }
            .padding(.top, 61)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    addSheet()
}
