//
//  FullScreenCoverExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/31.
//

import SwiftUI
import SwiftUIPresent

struct FullScreenCoverExample: View {
    var body: some View {
        List {
            normalView
        }
    }
    
    @State private var isPresented = false
    private var normalView: some View {
        Section {
            Button {
                isPresented = true
            } label: {
                StatusRow("Present Sheet", isPresented)
            }
            .present(isPresented: $isPresented, style: .fullScreenCover.backgroundColor(.systemYellow)) {
                VStack {
                    Sample.text
                    Button("Dismiss") {
                        isPresented = false
                    }
                }
                .padding()
            }
        }
    }
}

struct FullScreenCoverExample_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverExample()
    }
}
