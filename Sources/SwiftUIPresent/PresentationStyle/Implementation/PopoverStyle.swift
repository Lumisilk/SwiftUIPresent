//
//  PopoverStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/29.
//

import UIKit
import SwiftUI

public struct PopoverStyle: PresentationStyle {
    
    fileprivate var backgroundColor: UIColor?
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> PopoverHostingController {
        PopoverHostingController(style: self, configuration: configuration)
    }
    
    public func update(_ hostingController: PopoverHostingController, configuration: PresentationConfiguration) {
        hostingController.update(style: self, configuration: configuration)
    }
}

extension PopoverStyle {
    public func backgroundColor(_ color: UIColor) -> PopoverStyle {
        var modified = self
        modified.backgroundColor = color
        return modified
    }
}

public class PopoverHostingController: UIHostingController<AnyView>, UIPopoverPresentationControllerDelegate {
    
    private var style: PopoverStyle
    private var configuration: PresentationConfiguration
    
    public init(style: PopoverStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        super.init(rootView: AnyView(EmptyView()))
        update(style: style, configuration: configuration)
        
        modalPresentationStyle = .popover
        guard let popoverPresentationController else { return }
        popoverPresentationController.delegate = self
        popoverPresentationController.canOverlapSourceViewRect = true
        popoverPresentationController.sourceView = configuration.anchorView
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(style: PopoverStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        rootView = AnyView(
            SizeDetectView(content: configuration.content) { [weak self] size in
                self?.preferredContentSize = size
            }
        )
        updateStyle()
    }
    
    private func updateStyle() {
        if let backgroundColor = style.backgroundColor, view.backgroundColor != backgroundColor {
            view.backgroundColor = backgroundColor
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        configuration.isPresented.wrappedValue = false
    }
}

public extension PresentationStyle where Self == PopoverStyle {
    static var popover: PopoverStyle {
        PopoverStyle()
    }
}

private struct SizeDetectView: View {
    let content: AnyView
    let onChange: (CGSize) -> Void
    
    var body: some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear { onChange(geo.size) }
                        .onChange(of: geo.size, perform: onChange)
                }
            )
    }
}
