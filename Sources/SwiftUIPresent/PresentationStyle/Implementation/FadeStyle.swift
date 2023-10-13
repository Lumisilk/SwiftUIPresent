//
//  FadeStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

public struct FadeStyle: PresentationStyle {
    
    fileprivate var backgroundColor: UIColor?
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> FadeStyleHostingController {
        FadeStyleHostingController(style: self, configuration: configuration)
    }
    
    public func update(_ hostingController: FadeStyleHostingController, configuration: PresentationConfiguration) {
        hostingController.update(style: self, configuration: configuration)
    }
}

extension FadeStyle {
    public func backgroundColor(_ color: UIColor) -> FadeStyle {
        var modified = self
        modified.backgroundColor = color
        return modified
    }
}

public class FadeStyleHostingController: UIHostingController<AnyView> {
    
    private var style: FadeStyle
    
    public init(style: FadeStyle, configuration: PresentationConfiguration) {
        self.style = style
        super.init(rootView: configuration.content)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = nil
        updateStyle()
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(style: FadeStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.rootView = configuration.content
        updateStyle()
    }
    
    private func updateStyle() {
        if let backgroundColor = style.backgroundColor, view.backgroundColor != backgroundColor {
            view.backgroundColor = backgroundColor
        }
    }
}

public extension PresentationStyle where Self == FadeStyle {
    static var fade: FadeStyle {
        FadeStyle()
    }
}
