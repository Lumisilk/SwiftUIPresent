//
//  PopoverStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/29.
//

import UIKit
import SwiftUI

public struct PopoverStyle: PresentationStyle {
    
    let backgroundColor: UIColor?
    
    public init(backgroundColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
    }
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> PopoverHostingController {
        PopoverHostingController(configuration: configuration, backgroundColor: backgroundColor)
    }
    
    public func update(_ hostingController: PopoverHostingController, configuration: PresentationConfiguration) {
        hostingController.update(configuration: configuration, backgroundColor: backgroundColor)
    }
}

public class PopoverHostingController: UIHostingController<AnyView>, UIPopoverPresentationControllerDelegate {
    
    private var isPresented: Binding<Bool>
    
    init(configuration: PresentationConfiguration, backgroundColor: UIColor?) {
        self.isPresented = configuration.isPresented
        super.init(rootView: AnyView(EmptyView()))
        update(configuration: configuration, backgroundColor: backgroundColor)
        
        modalPresentationStyle = .popover
        popoverPresentationController?.delegate = self
        popoverPresentationController?.canOverlapSourceViewRect = true
        popoverPresentationController?.sourceView = configuration.anchorView
        popoverPresentationController?.sourceRect = configuration.anchorView.frame
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(configuration: PresentationConfiguration, backgroundColor: UIColor?) {
        isPresented = configuration.isPresented
        rootView = AnyView(
            SizeDetectView(content: configuration.content) { [weak self] size in
                self?.preferredContentSize = size
            }
        )
        if let backgroundColor {
            view.backgroundColor = backgroundColor
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isPresented.wrappedValue = false
    }
}

public extension PresentationStyle where Self == PopoverStyle {
    static var popover: PopoverStyle {
        PopoverStyle()
    }
    
    static func popover(backgroundColor: UIColor) -> PopoverStyle {
        PopoverStyle(backgroundColor: backgroundColor)
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
