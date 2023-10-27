//
//  PopoverExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI

struct PopoverExample: View {
    
    var body: some View {
        List {
            Section {
                shortText
                longText
            }
            Section {
                resizable
                unlimitedColor
            }
            Section {
                coloredPopover
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
        .present(isPresented: $isLongPresented, style: .popover.backgroundColor(UIColor(cgColor: color))) {
            Sample.text
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
            .animation(.default, value: sizeFlag)
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
    
    @State private var color: CGColor = UIColor.systemBackground.cgColor
    @State private var isColoredPopoverPresented = false
    private var coloredPopover: some View {
        Section {
            ColorPicker("Background Color", selection: $color)
            Button {
                isColoredPopoverPresented = true
            } label: {
                StatusRow("Colored Background Sheet", isColoredPopoverPresented)
            }
            .present(isPresented: $isColoredPopoverPresented, style: .popover.backgroundColor(UIColor(cgColor: color))) {
                Sample.text.padding()
            }
        }
    }
}

struct PopoverExample_Previews: PreviewProvider {
    static var previews: some View {
        PopoverExample()
    }
}
