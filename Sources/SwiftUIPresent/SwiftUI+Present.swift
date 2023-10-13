//
//  SwiftUI+Present.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import SwiftUI

public extension View {
    /// Present a view with a specific style when the Boolean binding value you provide is true.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the view that you create in the modifier’s content closure.
    ///   - style: The presentation style that determines how the view is presented.
    ///   - content: A closure that returns the content to be presented.
    func present(
        isPresented: Binding<Bool>,
        style: some PresentationStyle,
        @ViewBuilder content: () -> some View
    ) -> some View {
        modifier(BoolPresentationModifier(isPresented: isPresented, style: style, presentContent: content()))
    }
    
    /// Presents a view  with a specific style using the given item as a data source for the view's content.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the presented view. When item is non-nil, SwiftUIPresent passes the item’s content to the modifier’s closure.
    ///   You display this content in the presented view that you create that the system displays to the user. If item changes, SwiftUIPresent dismisses the view and replaces it with a new one using the same process.
    ///   - style: The presentation style that determines how the view is presented.
    ///   - content: A closure that returns the content to be presented.
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
            content.background { anchorView }
        } else {
            content.background(anchorView)
        }
    }
    
    private var anchorView: some View {
        PresentationAnchorView(id: id, isPresented: $isPresented, style: style, content: presentContent)
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
