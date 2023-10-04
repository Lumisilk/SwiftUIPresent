//
//  PresentationItemAnchorView.swift
//  
//
//  Created by ribilynn on 2023/10/03.
//

import UIKit
import SwiftUI

struct PresentationItemAnchorView<Item: Identifiable, Style: PresentationStyle, Content: View>: UIViewRepresentable {

    @Binding var item: Item?
    var style: Style
    var content: (Item) -> Content
    
    func makeUIView(context: Context) -> PresentationItemAnchorUIView<Item, Style, Content> {
        PresentationItemAnchorUIView(
            item: $item,
            style: style,
            transaction: context.transaction,
            content: content
        )
    }

    func updateUIView(_ uiView: PresentationItemAnchorUIView<Item, Style, Content>, context: Context) {
        uiView.update(
            item: $item,
            style: style,
            transaction: context.transaction,
            content: content
        )
    }
}

class PresentationItemAnchorUIView<Item: Identifiable, Style: PresentationStyle, Content: View>: UIView {
    
    private var previousID: Item.ID?
    private var item: Binding<Item?>
    private var style: Style
    private var transaction: Transaction
    private var content: (Item) -> Content
    
    private var coordinator: PresentationCoordinator?
    
    init(item: Binding<Item?>, style: Style, transaction: Transaction, content: @escaping (Item) -> Content) {
        self.item = item
        self.previousID = item.wrappedValue?.id
        self.style = style
        self.transaction = transaction
        self.content = content
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        if let window, coordinator == nil {
            var rootViewController = window.rootViewController
            while let current = rootViewController {
                if isDescendant(of: current.view) {
                    coordinator = current.presentationCoordinator
                    return
                } else {
                    rootViewController = current.presentedViewController
                }
            }
        }
    }
    
    func update(item: Binding<Item?>, style: Style, transaction: Transaction, content: @escaping (Item) -> Content) {
        if let previousID, item.wrappedValue?.id != previousID {
            coordinator?.remove(id: previousID)
        }
        self.item = item
        self.previousID = item.wrappedValue?.id
        self.style = style
        self.transaction = transaction
        self.content = content
        registerIfNeeded()
    }
    
    private func registerIfNeeded() {
        if let item = item.wrappedValue {
            coordinator?.register(
                configuration: PresentationConfiguration(
                    id: item.id,
                    isPresented: self.item.convertToBool(),
                    anchorView: self,
                    transaction: transaction,
                    content: AnyView(content(item))
                ),
                style: style
            )
        }
    }
}
