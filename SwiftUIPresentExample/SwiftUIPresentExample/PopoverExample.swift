//
//  PopoverExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI

struct PopoverExample: View {
    
    @State private var isPopoverLargePresented = false
    
    var body: some View {
        List {
            Section {
                shortText
                longText
            }
            Section {
                switchButton
            }
            Section {
                resizable
                unlimitedColor
            }
        }
        .navigationTitle(Text("Popover"))
    }
    
    @State private var isShortPresented = false
    private var shortText: some View {
        Button {
            isShortPresented = true
        } label: {
            StatusRow("Short Text", isShortPresented)
        }
        .present(isPresented: $isShortPresented, style: .popover) {
            Text("Short Text")
            .padding()
        }
    }
    
    @State private var isLongPresented = false
    private var longText: some View {
        Button {
            isLongPresented = true
        } label: {
            StatusRow("Long Text", isLongPresented)
        }
        .present(isPresented: $isLongPresented, style: .popover) {
            Sample.text
                .padding()
        }
    }
    
    @State private var isSwitchPresented = false
    private var switchButton: some View {
        Button {
            isSwitchPresented = true
        } label: {
            StatusRow("Switch Popover", isSwitchPresented)
        }
        .present(isPresented: $isSwitchPresented, style: .popover) {
            Button("Switch to short text") {
                isSwitchPresented = false
                isShortPresented = true
            }
            .padding()
        }
    }
    
    @State private var isResizablePresented = false
    @State private var sizeFlag = false
    private var resizable: some View {
        Button {
            isResizablePresented = true
        } label: {
            StatusRow("Resizable", isResizablePresented)
        }
        .present(isPresented: $isResizablePresented, style: .popover) {
            Button {
                sizeFlag.toggle()
            } label: {
                Text("Resize")
                    .frame(
                        width: sizeFlag ? 300: 200,
                        height: sizeFlag ? 200: 300
                    )
            }
            .border(Color.red)
            .padding()
        }
    }
    
    @State private var isExtendPresented = false
    private var unlimitedColor: some View {
        Button {
            isExtendPresented = true
        } label: {
            StatusRow("Unlimited Size", isExtendPresented)
        }
        .present(isPresented: $isExtendPresented, style: .popover) {
            Color.blue.padding()
        }
    }
}

struct PopoverExample_Previews: PreviewProvider {
    static var previews: some View {
        PopoverExample()
    }
}
