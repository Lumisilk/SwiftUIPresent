//
//  AllPreview.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/27.
//

import SwiftUI
import SwiftUIPresent

struct AllPreview: View {
    
    var body: some View {
        NavigationView {
            List {
                fade
                popover
                sheet
            }
            .navigationTitle("SwiftUIPresent")
        }
    }
    
    @State private var isFadePresented = false
    private var fade: some View {
        Button("Fade") {
            isFadePresented = true
        }
        .present(
            isPresented: $isFadePresented,
            style: .fade.backgroundColor(UIColor.black.withAlphaComponent(0.4))
        ) {
            VStack(spacing: 8) {
                Sample.text
                Button("Dismiss") {
                    isFadePresented = false
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(8)
            .padding()
        }
    }
    
    @State private var isPopoverPresented = false
    private var popover: some View {
        Button("Popover") {
            isPopoverPresented = true
        }
        .present(isPresented: $isPopoverPresented, style: .popover) {
            Sample.text
                .padding()
        }
    }
    
    @State private var isSheetPresented = false
    private var sheet: some View {
        var sheetStyle = SheetStyle()
        if #available(iOS 15, *) {
            sheetStyle = sheetStyle.detents([.medium()])
        }
        return Button("Sheet") {
            isSheetPresented = true
        }
        .present(isPresented: $isSheetPresented, style: sheetStyle) {
            Sample.text
                .padding()
        }
    }
}

#Preview {
    AllPreview()
}
