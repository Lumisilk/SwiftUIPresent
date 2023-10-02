//
//  FadeStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

public struct FadePresentationStyle: PresentationStyle {
    
    let backgroundColor: UIColor
    
    public init(backgroundColor: UIColor = .clear) {
        self.backgroundColor = backgroundColor
    }
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> FadeStyleHostingController {
        FadeStyleHostingController(configuration, backgroundColor: backgroundColor)
    }
    
    public func update(_ hostingController: FadeStyleHostingController, configuration: PresentationConfiguration) {
        hostingController.rootView = configuration.content
    }
}

public class FadeStyleHostingController: UIHostingController<AnyView> {
    
    let backgroundColor: UIColor
    
    public init(_ configuration: PresentationConfiguration, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(rootView: configuration.content)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = backgroundColor
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension PresentationStyle where Self == FadePresentationStyle {
    static var fade: FadePresentationStyle {
        FadePresentationStyle()
    }
    
    static func fade(backgroundColor: UIColor) -> FadePresentationStyle {
        FadePresentationStyle(backgroundColor: backgroundColor)
    }
}
