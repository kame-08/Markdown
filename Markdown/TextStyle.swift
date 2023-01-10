//
//  TextStyle.swift
//  Markdown
//
//  Created by Ryo on 2023/01/05.
//

import Foundation
import SwiftUI
import RegexBuilder

func TextStyle(text: String) -> Font {
    if text.prefix(2) == "# " {
        return .largeTitle
    } else if text.prefix(3) == "## " {
        return .title
    } else if text.prefix(4) == "### " {
        return .title2
    } else if text.prefix(5) == "#### " {
        return .title3
    } else if text.prefix(6) == "##### " {

    } else if text.prefix(7) == "###### " {
        
    } else if text.prefix(2) == "- " || text.prefix(2) == "* " || text.prefix(2) == "+ " {
        // 箇条書き
        return .itemization
        
    } else if text.prefix(1) == ">" {
        // 引用
        return .reference
    } else if text == "```" {
        // コードブロックの始まりか終わり
        
    } else if text.prefix(8) == "https://" || text.prefix(7) == "http://" {
        // URL 特に何も指定しない
    } else if text.prefix(5) == "- [x]" {
        
    } else if text.prefix(3) == "---" || text.prefix(3) == "___" || text.prefix(3) == "***" || text.prefix(2) == "—-"{
        //　区切り線
        return .delimiter
    } else if (text.wholeMatch(of: urlRegex) != nil){
        //　画像
        return .image
    } else if (text.firstMatch(of: numRegex) != nil){
        return .num
    }
    
    return.body
}

extension Font {
    /// 引用
    static var reference: Font {
        Font.custom("reference", size: 24)
    }
    /// 区切り線
    static var delimiter: Font {
        Font.custom("delimiter", size: 24)
    }
    static var image: Font {
        Font.custom("image", size: 24)
    }
    static var itemization: Font {
        Font.custom("itemization", size: 24)
    }
    static var num: Font {
        Font.custom("num", size: 24)
    }
}

let urlRegex = Regex {
    "!["
    Capture {
        ZeroOrMore(.any)
    }
    "]("
    Capture {
        ZeroOrMore(.any)
    }
    ")"
}

let numRegex = Regex {
    // 先頭に数字がある時のみ
    Anchor.startOfLine
    OneOrMore(.digit)
    ". "
}

extension String {
    func getAttributedString() -> AttributedString {
        do {
            let attributedString = try AttributedString(markdown: self)
            return attributedString
        } catch {
            print("Couldn't parse: \(error)")
        }
        return AttributedString("Error parsing markdown")
    }
    
    func getImageURL() -> URL {
        
        let regex = Regex {
            "!["
            Capture {
                ZeroOrMore(.any)
            }
            "]("
            Capture() {
                OneOrMore(.any)
                // 下の2つだと取得できない
                // "![text](https://developer.apple.com)" の最後の)を消すと正しく取得できる
                // ZeroOrMore(.url(), .eager)
                // .url()
            }
            ")"
        }

        if let match = self.wholeMatch(of: regex) {
            //            print("正しい")
//            print(match.1) // text
            return URL(string: String(match.2))!
        }
        else {
            return URL(string: "https://")!
        }
    }
    
    func getNum() -> String {
        
        let regex = Regex {
            Capture() {
                OneOrMore(.digit)
            }
            ". "
        }
        if let match = self.firstMatch(of: regex) {

            return String(match.1)+"."
        }
return self
    }
}

let regex = Regex {
    Anchor.startOfLine
    Repeat(count: 4) {
        One(.digit)
    }
    "-"
    Repeat(count: 2) {
        One(.digit)
    }
    "-"
    Repeat(count: 2) {
        One(.digit)
    }
    Anchor.endOfLine
}

