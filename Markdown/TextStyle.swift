//
//  TextStyle.swift
//  Markdown
//
//  Created by Ryo on 2023/01/05.
//

import Foundation
import SwiftUI

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
        print("reference")
        // 引用
        return .reference
    } else if text == "```" {
        // コードブロックの始まりか終わり
        
    } else if text.prefix(8) == "https://" || text.prefix(7) == "http://" {
        // URL 特に何も指定しない
    } else if text.prefix(5) == "- [x]" {
        
    } else if text.prefix(3) == "---" || text.prefix(3) == "___" || text.prefix(3) == "***" || text.prefix(2) == "—-"{
        //　区切り線
        print("delimiter")
        return .delimiter
    } else if text.prefix(2) == "!["{
        //　画像
        return .image
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
    
}
