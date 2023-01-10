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
                    }else if TextStyle(text: atext) == .image {
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
                    }else if TextStyle(text: atext) == .itemization {
                        HStack {
                            Circle()
                                .frame(width: 5)
                            
                            Text(atext.getAttributedString())
                        }
                        
                    }else if TextStyle(text: atext) == .reference {
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
        let url = self.components(separatedBy: "(")
        let url2 = url[1].components(separatedBy: ")")
        return URL(string: url2[0])!
    }
}

struct Markdown_Previews: PreviewProvider {
    static var previews: some View {
        //        Markdown(.constant("# Apple\nRyo"))
        Markdown(.constant("""
> Apple
> Apple
![qiita-square.png](https://qiita-image-store.s3.amazonaws.com/0/126861/90386757-fd96-8ba6-3477-485669713c55.png)
"""))
    }
}
