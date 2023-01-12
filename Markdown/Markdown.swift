//
//  Markdown.swift
//  Markdown
//
//  Created by Ryo on 2023/01/05.
//

import SwiftUI

struct Markdown: View {
    @Binding var text: String
    @State var arrText: [String] = []
    
    init(_ text: Binding<String>) {
        // _text = State(initialValue: text)
        self._text = text
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                ForEach(arrText, id: \.self, content: { atext in
                    if TextStyle(text: atext) == .delimiter {
                        Divider()
                    } else if TextStyle(text: atext) == .image {
                        AsyncImage(url: atext.getImageURL()) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 4.0)
                        } placeholder: {
                            HStack {
                                ProgressView()
                                // 代替テキスト
                                Text(atext.getAttributedString())
                            }
                        }
                    } else if TextStyle(text: atext) == .itemization {
                        HStack {
                            Circle()
                                .frame(width: 5)
                            
                            Text(atext.getAttributedString())
                        }
                        
                    } else if TextStyle(text: atext) == .reference {
                        HStack {
                            Rectangle()
                                .foregroundColor(.orange)
                                .frame(width: 5, height: 0.0)
                            Text(atext.getAttributedString())
                        }
                        .background(
                            HStack {
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: 5)
                                    .frame(maxHeight: .infinity)
                                Spacer()
                            }
                        )
                        
                    } else if TextStyle(text: atext) == .num{
                        HStack {
                            Text("\(atext.getNum())")
                                .font(.system(.body, design: .monospaced))
                            Text(atext.getAttributedString())
                        }
                        
                    } else {
                        Text(atext.getAttributedString())
                            .font(TextStyle(text: atext))
                    }
                    
                })
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        .task {
            arrText = text.components(separatedBy: "\n")
        }
        .onChange(of: text) { newValue in
            arrText = newValue.components(separatedBy: "\n")
        }
    }
}


struct Markdown_Previews: PreviewProvider {
    static var previews: some View {
        Markdown(.constant("""
# Apple
> Apple
+ Apple
1. Apple
![qiita-square.png](https://storage.googleapis.com/zenn-user-upload/avatar/8cb73f5e8f.jpeg)
"""))
    }
}
