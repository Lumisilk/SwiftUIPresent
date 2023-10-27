//
//  SheetExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI
import SwiftUIPresent

struct SheetExample: View {
    
    var body: some View {
        List {
            normalSheet
            
            if #available(iOS 15, *) {
                detentSheet
            }
            
            itemSheet
            coloredSheet
        }
        .navigationTitle(Text("Sheet"))
    }
    
    @State private var isPresented = false
    private var normalSheet: some View {
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
            Text("It is recommended to use the official sheet modifier if it meets your requirements.")
        }
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
                style: .sheet.detents(detentFlag ? [.large()] : [.medium()])
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
    
    @State private var item: MyItem?
    private var itemSheet: some View {
        Section {
            Text("Item: \(item?.value ?? "nil")")
            Button {
                item = MyItem(value: "First")
            } label: {
                StatusRow("Set Item to First", item != nil)
            }
            .present(item: $item, style: .sheet) { item in
                VStack {
                    Text(item.value)
                    Button("Set item to Second") {
                        self.item = MyItem(value: "Second")
                    }
                }
            }
        }
    }
    
    @State private var color: CGColor = UIColor.systemOrange.cgColor
    @State private var isColoredSheetPresented = false
    private var coloredSheet: some View {
        Section {
            ColorPicker("Background Color", selection: $color)
            Button {
                isColoredSheetPresented = true
            } label: {
                StatusRow("Colored Background Sheet", isColoredSheetPresented)
            }
            .present(isPresented: $isColoredSheetPresented, style: .sheet.backgroundColor(UIColor(cgColor: color))) {
                Text("🎨")
            }
        }
    }
}

struct SheetExample_Previews: PreviewProvider {
    static var previews: some View {
        SheetExample()
    }
}
