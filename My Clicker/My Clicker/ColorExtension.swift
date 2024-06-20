//
//  ColorExtension.swift
//  My Clicker
//
//  Created by 세린맥북 on 6/18/24.
//

import SwiftUI
extension Color{
    static let basicGreen = Color(hex: "30D158")
    static let backgroundGreen = Color(hex: "29AF4A")
    static let lightGray = Color(hex: "7D7D7D")
    static let fog = Color(hex: "EAEAEA")
    }

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")

    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)

    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
