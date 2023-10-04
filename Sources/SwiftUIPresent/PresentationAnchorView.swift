//
//  PresentationAnchorView.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

struct PresentationAnchorView<Style: PresentationStyle, Content: View>: UIViewRepresentable {

    var id: Namespace.ID
    @Binding var isPresented: Bool
    var style: Style
    var content: Content
    
    func makeUIView(context: Context) -> PresentationAnchorUIView<Style, Content> {
        PresentationAnchorUIView(
            id: id,
            isPresented: $isPresented,
            style: style,
            transaction: context.transaction,
            content: content
        )
    }

    func updateUIView(_ uiView: PresentationAnchorUIView<Style, Content>, context: Context) {
        uiView.update(
            id: id,
            isPresented: $isPresented,
            style: style,
            transaction: context.transaction,
            content: content
        )
    }
}

class PresentationAnchorUIView<Style: PresentationStyle, Content: View>: UIView {
    
    private var id: Namespace.ID
    private var isPresented: Binding<Bool>
    private var style: Style
    private var transaction: Transaction
    private var content: Content
    
    private var coordinator: PresentationCoordinator?
    
    init(id: Namespace.ID, isPresented: Binding<Bool>, style: Style, transaction: Transaction, content: Content) {
        self.id = id
        self.isPresented = isPresented
        self.style = style
        self.transaction = transaction
        self.content = content
        super.init(frame: .zero)
        isUserInteractionEnabled = false
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
    
    func update(id: Namespace.ID, isPresented: Binding<Bool>, style: Style, transaction: Transaction, content: Content) {
        self.id = id
        self.isPresented = isPresented
        self.style = style
        self.transaction = transaction
        self.content = content
        update()
    }
    
    private func update() {
        if isPresented.wrappedValue {
            coordinator?.register(
                configuration: PresentationConfiguration(
                    id: id,
                    isPresented: isPresented,
                    anchorView: self,
                    transaction: transaction,
                    content: AnyView(content)
                ),
                style: style
            )
        } else {
            coordinator?.remove(id: id)
        }
    }
}
