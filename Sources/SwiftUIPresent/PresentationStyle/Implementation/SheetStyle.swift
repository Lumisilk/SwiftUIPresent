//
//  SheetStyle.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

public struct SheetStyle: PresentationStyle {
    
    private let detents: Any?
    
    public init() {
        detents = nil
    }
    
    @available(iOS 15, *)
    public init(detents: [UISheetPresentationController.Detent]) {
        self.detents = detents
    }
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> SheetStyleHostingController {
        let controller = SheetStyleHostingController(configuration: configuration)
        controller.setupDetents(detents)
        return controller
    }
    
    public func update(_ hostingController: SheetStyleHostingController, configuration: PresentationConfiguration) {
        hostingController.update(configuration)
        hostingController.setupDetents(detents)
    }
}

public class SheetStyleHostingController: UIHostingController<AnyView>, UIAdaptivePresentationControllerDelegate {
    
    private var configuration: PresentationConfiguration
    
    init(configuration: PresentationConfiguration) {
        self.configuration = configuration
        super.init(rootView: configuration.content)
        presentationController?.delegate = self
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ configuration: PresentationConfiguration) {
        self.configuration = configuration
        self.rootView = configuration.content
    }
    
    func setupDetents(_ detents: Any?) {
        if #available(iOS 15.0, *), let detents = detents as? [UISheetPresentationController.Detent] {
            if configuration.transaction.disablesAnimations {
                sheetPresentationController?.detents = detents
            } else {
                sheetPresentationController?.animateChanges {
                    sheetPresentationController?.detents = detents
                }
            }
        }
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        configuration.isPresented.wrappedValue = false
    }
}

public extension PresentationStyle where Self == SheetStyle {
    static var sheet: SheetStyle {
        SheetStyle()
    }
    
    @available(iOS 15, *)
    static func sheet(detents: [UISheetPresentationController.Detent]) -> SheetStyle {
        SheetStyle(detents: detents)
    }
}
