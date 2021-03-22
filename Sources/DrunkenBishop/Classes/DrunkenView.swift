//
//  DrunkenView.swift
//  DrunkenBishop
//
//  Created by Luis Javier Camargo Perez on 22/03/21.
//


import SwiftUI
import CommonCrypto

@available(iOS 13.0, OSX 10.15, *)
public struct DrunkenView: View {
    
    private let bishop: DrunkenBishop
    private let hex: String?
    private let key: String?
    
    init(hex: String) {
        self.bishop = DrunkenBishop()
        self.hex = hex
        self.key = nil
    }
    
    init(key: String) {
        self.bishop = DrunkenBishop()
        self.key = key
        self.hex = nil
    }
    
    public var body: some View {
        let attrs: [[String]]
        if hex != nil {
            attrs = bishop.attributedRepresentation(from: hex!)
        } else {
            attrs = bishop.attributedKeyRepresentation(from: key!)
        }
        
        return attrs.reduce(Text("")) { texts, attr in
            let color = Color(hex: attr[1])
            return texts + Text(attr[0])
                .foregroundColor(color)
                .font(.system(size: 20, design: .monospaced))
        }
    }
    
    let onAction: () -> Void = {}
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    func toHex(uppercase: Bool = true, prefix: String = "", separator: String = "") -> String {
            return unicodeScalars.map { prefix + .init($0.value, radix: 16, uppercase: uppercase) } .joined(separator: separator)
        }
}

