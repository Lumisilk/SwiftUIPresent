//
//  SwiftUI+Present.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import SwiftUI

public extension View {
    func present(
        isPresented: Binding<Bool>,
        style: some PresentationStyle,
        @ViewBuilder content: () -> some View
    ) -> some View {
        modifier(BoolPresentationModifier(isPresented: isPresented, style: style, presentContent: content()))
    }
    
    func present<Item: Identifiable>(
        item: Binding<Item?>,
        style: some PresentationStyle,
        @ViewBuilder content: @escaping (Item) -> some View
    ) -> some View {
        modifier(ItemPresentationModifier(item: item, style: style, presentContent: content))
    }
}

struct BoolPresentationModifier<Style: PresentationStyle, PresentContent: View>: ViewModifier {
    
    @Namespace private var id
    @Binding var isPresented: Bool
    let style: Style
    let presentContent: PresentContent
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .background {
                    PresentationAnchorView(id: id, isPresented: $isPresented, style: style, content: presentContent)
                }
        } else {
            content
                .background(
                    PresentationAnchorView(id: id, isPresented: $isPresented, style: style, content: presentContent)
                )
        }
    }
}

struct ItemPresentationModifier<Item: Identifiable, Style: PresentationStyle, PresentContent: View>: ViewModifier {
    
    @Binding var item: Item?
    let style: Style
    let presentContent: (Item) -> PresentContent
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .background {
                    PresentationItemAnchorView(item: $item, style: style, content: presentContent)
                }
        } else {
            content
                .background(
                    PresentationItemAnchorView(item: $item, style: style, content: presentContent)
                )
        }
    }
}
