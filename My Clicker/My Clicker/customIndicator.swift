//
//  CustomIndicator.swift
//  My Clicker
//
//  Created by 세린맥북 on 6/20/24.
//


import SwiftUI

struct CustomPageIndicator: View {
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
