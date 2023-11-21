//
//  SheetStyle.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

/// A presentation style that partially covers the underlying content.
///
/// Note that you should only use SwiftUIPresent's sheet style if the official SwiftUI `sheet` modifier doesn't meet your needs.
/// Otherwise you should always use the official SwiftUI version.
public struct SheetStyle: PresentationStyle {
    
    fileprivate var _detents: Any?
    fileprivate var backgroundColor: UIColor?
    fileprivate var onDismiss: (() -> Void)?
    
    public init() {}
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> SheetStyleHostingController {
        SheetStyleHostingController(style: self, configuration: configuration)
    }
    
    public func update(_ hostingController: SheetStyleHostingController, configuration: PresentationConfiguration) {
        hostingController.update(style: self, configuration: configuration)
    }
}

extension SheetStyle {
    /// Modify the sheet style to use the specified detents of the sheet view.
    /// - Parameter detents: The array of heights where a sheet can rest.
    @available(iOS 15, *)
    public func detents(_ detents: [UISheetPresentationController.Detent]) -> SheetStyle {
        var modified = self
        modified._detents = detents
        return modified
    }
    
    /// Modify the sheet style to use the specified background color for the sheet view.
    ///
    /// By default, the background color is system's background color unless altered by this function.
    public func backgroundColor(_ color: UIColor) -> SheetStyle {
        var modified = self
        modified.backgroundColor = color
        return modified
    }
    
    /// The closure to execute after dismissing the sheet by user.
    ///
    /// This action closure is not called if the sheet is dismissed programmatically.
    public func onDismiss(_ action: @escaping () -> Void) -> SheetStyle {
        var modified = self
        modified.onDismiss = action
        return modified
    }
}

/// The view controller responsible for displaying the provided content view to the screen in the `pageSheet` style.
///
/// Typically you don't use this view controller directly, but instead use the sheet style.
public class SheetStyleHostingController: UIHostingController<AnyView>, UIAdaptivePresentationControllerDelegate {
    
    private var style: SheetStyle
    private var configuration: PresentationConfiguration
    
    init(style: SheetStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        super.init(rootView: configuration.content)
        presentationController?.delegate = self
        modalPresentationStyle = .pageSheet
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
        style.onDismiss?()
    }
}

public extension PresentationStyle where Self == SheetStyle {
    /// A presentation style that partially covers the underlying content.
    ///
    /// Note that you should only use SwiftUIPresent's sheet style if the official SwiftUI `sheet` modifier doesn't meet your needs.
    /// Otherwise you should always use the official SwiftUI version.
    static var sheet: SheetStyle {
        SheetStyle()
    }
}
