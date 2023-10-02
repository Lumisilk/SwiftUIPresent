//
//  SheetExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI
import SwiftUIPresent

struct SheetExample: View {
    
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section {
                Button {
                    isPresented = true
                } label: {
                    StatusRow("Present Sheet", isPresented)
                }
                .present(isPresented: $isPresented, style: .sheet) {
                    VStack {
                        Sample.text
                        Button("Dismiss") {
                            isPresented = false
                        }
                    }
                }
            } footer: {
                Text("Always use the ofiicial sheet modifier if it's satisfied.")
            }
        }
        .navigationTitle(Text("Sheet"))
    }
}

struct SheetExample_Previews: PreviewProvider {
    static var previews: some View {
        SheetExample()
    }
}
