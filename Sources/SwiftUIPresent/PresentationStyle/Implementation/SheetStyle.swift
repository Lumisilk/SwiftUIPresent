//
//  SheetStyle.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

public struct SheetStyle: PresentationStyle {
    
    fileprivate var _detents: Any?
    fileprivate var backgroundColor: UIColor?
    
    public init() {}
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> SheetStyleHostingController {
        SheetStyleHostingController(style: self, configuration: configuration)
    }
    
    public func update(_ hostingController: SheetStyleHostingController, configuration: PresentationConfiguration) {
        hostingController.update(style: self, configuration: configuration)
    }
}

extension SheetStyle {
    @available(iOS 15, *)
    public func detents(_ detents: [UISheetPresentationController.Detent]) -> SheetStyle {
        var modified = self
        modified._detents = detents
        return modified
    }
    
    public func backgroundColor(_ color: UIColor) -> SheetStyle {
        var modified = self
        modified.backgroundColor = color
        return modified
    }
}

public class SheetStyleHostingController: UIHostingController<AnyView>, UIAdaptivePresentationControllerDelegate {
    
    private var style: SheetStyle
    private var configuration: PresentationConfiguration
    
    public init(style: SheetStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        super.init(rootView: configuration.content)
        presentationController?.delegate = self
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateStyle()
    }
    
    public func update(style: SheetStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        self.rootView = configuration.content
        updateStyle()
    }
    
    private func updateStyle() {
        if #available(iOS 15.0, *), let detents = style._detents as? [UISheetPresentationController.Detent] {
            if configuration.transaction.disablesAnimations {
                sheetPresentationController?.detents = detents
            } else {
                sheetPresentationController?.animateChanges {
                    sheetPresentationController?.detents = detents
                }
            }
        }
        if let backgroundColor = style.backgroundColor, view.backgroundColor != backgroundColor {
            view.backgroundColor = backgroundColor
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
}
