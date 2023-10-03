//
//  Helper.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI

enum Sample {
    static var text: Text {
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    }
}

struct StatusRow: View {
    
    let text: String
    let isPresented: Bool
    
    init(_ text: String, _ isPresented: Bool) {
        self.text = text
        self.isPresented = isPresented
    }
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            (isPresented ? Color.green : Color.red)
                .frame(maxWidth: 15, maxHeight: .infinity)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct MyItem: Identifiable {
    let value: String
    var id: String { value }
}
