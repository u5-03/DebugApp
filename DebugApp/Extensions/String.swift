//
//  String.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import Foundation

extension String {
    static var randomQuotations: String {
        let list: [String] = [
            "逃げちゃダメだ",
            "あんたバカァ？",
            "サービス、サービス♪",
            "奇跡を待つより捨て身の努力",
            "歌は文化の極み",
            "風呂は命の洗濯",
            "今度こそ君だけは幸せにしてみせるよ",
            "シナリオ通り",
            "気持ち悪い",
            "槍でやり直す",
            "知らない天井",
            "目標をセンターに入れて、スイッチ",
            "希望的観測は人が生きていくための必需品",
            "さようなら",
            "それはそれ、これはこれ",
            "あなたは死なないわ",
            "ぽかぽかする",
            "全開！",
            "にんにくラーメンチャーシュー抜き",
            "ぬるいな",
            "しっぽだ",
            "やったか",
            "え、動くの？",
            "縁が君を導くだろう",
            "31手目で君の詰みだ"
        ]
        let randomValue = Int.random(in: 0...list.count - 1)
        return list[randomValue]
    }
    static func random(length: Int? = nil) -> String {
        let adjustedLength = length ?? .random(in: 0...300)
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<adjustedLength {
            let randomValue = Int.random(in: 0 ... base.count - 1)
            let index: Index = base.index(base.startIndex, offsetBy: randomValue)
            let character: Character = base[index]
            randomString += String(character)
        }
        return randomString
    }
}
