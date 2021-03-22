//
//  DrunkenBishop.swift
//  DrunkenBishop
//
//  Created by Luis Javier Camargo Perez on 22/03/21.
//

import Foundation

public struct DrunkenBishop {
    let characters = " .o+=*BOX@%&#/^SE"
    let colors = [
        "#0000ff", "#0087ff", "#00d7ff", "#00ffd7",
        "#00ff87", "#00ff00", "#87ff00", "#d7ff00",
        "#ffff00", "#ffd700", "#ffaf00", "#ff8700",
        "#ff5f00", "#ff0000", "#ff5f5f", "#ff8787",
        "#ffafaf", "#ffd7d7"
    ]
    let startXPos = 8
    let startYPos = 4
    let cols = 17
    let rows = 9
    
    public init() {
        
    }
    
    public func representation(from hex: String) -> String {
        var xPos = startXPos
        var yPos = startYPos
        let binary = hex.replacingOccurrences(of:":", with:"").hexaToBinary
        let moves: [Move] = binary.pairs().map {
            switch $0 {
            case "00": return .upLeft
            case "01": return .upRight
            case "10": return .downLeft
            case "11": return .downRight
            default: return.downRight
            }
        }
        let matrix = moves.reduce(into: [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)) { field, move in
            xPos = move.move(x: xPos)
            yPos = move.move(y: yPos)
            xPos = clamp(value: xPos, bottom: 0, top: cols - 1)
            yPos = clamp(value: yPos, bottom: 0, top: rows - 1)
            field[yPos][xPos] += 1
        }
        return renderField(from: matrix)
    }
    
    private func getHex(from key: String) -> String {
        let replaced = key
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
        let encoded = Data(base64Encoded: replaced)!
        let decoded = String(data: encoded, encoding: .utf8)!
        let hash = decoded.sha1()
        let hex = hash.toHex()
        print("decoded \(decoded)")
        print("hash \(hash)")
        print("hex \(hex)")
        return hex
    }
    
    public func attributedRepresentation(from hex: String) -> [[String]] {
        return attributedChars(from: representation(from: hex))
    }
    
    public func attributedKeyRepresentation(from key: String) -> [[String]] {
        let hex = getHex(from: key)
        return attributedChars(from: representation(from: hex))
    }
    
    private func attributedChars(from string: String) -> [[String]] {
        return Array(string).map { char in
            let color = hexColor(from: char)
            return [String(char), color]
        }
    }
    
    private func clamp(value: Int, bottom: Int, top: Int) -> Int {
        return max(bottom, min(top, value))
    }
    
    private func symbol(from result: Int) -> Character {
        if (result >= characters.count) {
            return characters[characters.index(characters.startIndex, offsetBy:0)]
        }
        return characters[characters.index(characters.startIndex, offsetBy: result)]
    }
    
    private func renderField(from matrix: [[Int]]) -> String {
        let rows = matrix.reduce(into: "") { rows, row in
            print(">>>>>>>>> row \(row) len \(row.count)")
            let col = row.reduce(into: "") { cols, cell in
                cols.append(String(symbol(from: cell)))
            }
            rows.append("|\(col)|\r\n")
        }
        return "+-----------------+\r\n\(rows)+-----------------+"
    }
    
    private func hexColor(from char: Character) -> String {
        let index = characters.firstIndex(of: char)?.utf16Offset(in: characters) ?? 0
        return colors[index]
    }
}

enum Move {
    case upLeft
    case upRight
    case downLeft
    case downRight
    
    func move(x: Int) -> Int {
        switch self {
        case .upLeft: return x - 1
        case .upRight: return x + 1
        case .downLeft: return x - 1
        case .downRight: return x + 1
        }
    }

    func move(y: Int) -> Int {
        switch self {
        case .upLeft: return y - 1
        case .upRight: return y - 1
        case .downLeft: return y + 1
        case .downRight: return y + 1
        }
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}

extension String {
    var hexaToBinary: String {
        return hexaBytes.map {
            let binary = String($0, radix: 2)
            return repeatElement("0", count: 8-binary.count) + binary
        }.joined()
    }
    
    func pairs() -> [String] {
        return stride(from: 0, to: self.count, by: 2).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
