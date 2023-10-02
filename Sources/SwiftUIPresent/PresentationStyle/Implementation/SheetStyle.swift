//
//  SheetStyle.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

public struct SheetStyle: PresentationStyle {
    
    public init() {}
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> SheetStyleHostingController {
        SheetStyleHostingController(configuration: configuration)
    }
    
    public func update(_ hostingController: SheetStyleHostingController, configuration: PresentationConfiguration) {
        hostingController.rootView = configuration.content
    }
}

public class SheetStyleHostingController: UIHostingController<AnyView>, UIAdaptivePresentationControllerDelegate {
    
    private var isPresented: Binding<Bool>
    
    init(configuration: PresentationConfiguration) {
        isPresented = configuration.isPresented
        super.init(rootView: configuration.content)
        presentationController?.delegate = self
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isPresented.wrappedValue = false
    }
}

public extension PresentationStyle where Self == SheetStyle {
    static var sheet: SheetStyle {
        SheetStyle()
    }
}
