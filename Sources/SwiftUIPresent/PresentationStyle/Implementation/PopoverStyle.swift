//
//  PopoverStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/29.
//

import UIKit
import SwiftUI

/// A presentation style where the content is displayed in a popover view.
public struct PopoverStyle: PresentationStyle {
    
    fileprivate var backgroundColor: UIColor?
    fileprivate var onDismiss: (() -> Void)?
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> PopoverHostingController {
        PopoverHostingController(style: self, configuration: configuration)
    }
    
    public func update(_ hostingController: PopoverHostingController, configuration: PresentationConfiguration) {
        hostingController.update(style: self, configuration: configuration)
    }
}

extension PopoverStyle {
    /// Modify the popover style to use the specified background color for the popover bubble.
    ///
    /// By default, the background color is the blur effect of the system material unless altered by this method.
    public func backgroundColor(_ color: UIColor) -> PopoverStyle {
        var modified = self
        modified.backgroundColor = color
        return modified
    }
    
    /// The closure to execute after dismissing the sheet by user.
    ///
    /// This action closure is not called if the popover is dismissed programmatically.
    public func onDismiss(_ action: @escaping () -> Void) -> PopoverStyle {
        var modified = self
        modified.onDismiss = action
        return modified
    }
}

/// The view controller responsible for displaying the provided content view to the screen in the `popover` style.
///
/// Typically you don't use this view controller directly, but instead use the popover style.
public class PopoverHostingController: UIHostingController<AnyView>, UIPopoverPresentationControllerDelegate {
    
    private var style: PopoverStyle
    private var configuration: PresentationConfiguration
    
    init(style: PopoverStyle, configuration: PresentationConfiguration) {
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
        style.onDismiss?()
    }
}

public extension PresentationStyle where Self == PopoverStyle {
    /// A presentation style where the content is displayed in a popover view.
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
