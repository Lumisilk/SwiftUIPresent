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
            
            if #available(iOS 15, *) {
                detentSheet
            }
        }
        .navigationTitle(Text("Sheet"))
    }
    
    @State private var isDetentSheetPresented = false
    @State private var detentFlag = false
    @available(iOS 15, *)
    private var detentSheet: some View {
        Section {
            Button {
                isDetentSheetPresented = true
            } label: {
                StatusRow("Present Detent Sheet", isDetentSheetPresented)
            }
            .present(
                isPresented: $isDetentSheetPresented,
                style: .sheet(detents: detentFlag ? [.large()] : [.medium()])
            ) {
                ScrollView {
                    VStack(spacing: 9) {
                        Sample.text
                        Button("Toggle detent") {
                            detentFlag.toggle()
                        }
                        Button("Dismiss") {
                            isDetentSheetPresented = false
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct SheetExample_Previews: PreviewProvider {
    static var previews: some View {
        SheetExample()
    }
}
