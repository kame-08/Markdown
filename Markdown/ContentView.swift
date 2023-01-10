//
//  ContentView.swift
//  Markdown
//
//  Created by Ryo on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @FocusState private var focusedField: Bool
    
    var body: some View {
        HStack {
            TextEditor(text: $text)
                .focused($focusedField)
                .task {
                    focusedField = true
                }
            Divider()
            Markdown($text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(text: "# Apple\nRyo")
    }
}
