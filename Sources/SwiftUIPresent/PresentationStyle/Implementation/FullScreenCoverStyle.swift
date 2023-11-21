//
//  FullScreenCoverStyle.swift
//
//
//  Created by Lumisilk on 2023/10/31.
//

import SwiftUI

public struct FullScreenCoverStyle: PresentationStyle {
    fileprivate var backgroundColor: UIColor?
    
    public func makeHostingController(_ configuration: PresentationConfiguration) -> FullScreenCoverHostingController {
        FullScreenCoverHostingController(style: self, configuration: configuration)
    }
    
    public func update(_ hostingController: FullScreenCoverHostingController, configuration: PresentationConfiguration) {
        hostingController.update(style: self, configuration: configuration)
    }
}

extension FullScreenCoverStyle {
    /// Modify the overFullScreen style to use the specified background color for the presented view.
    ///
    /// By default, the background color is system's background color unless altered by this function.
    public func backgroundColor(_ color: UIColor) -> FullScreenCoverStyle {
        var modified = self
        modified.backgroundColor = color
        return modified
    }
}

public class FullScreenCoverHostingController: UIHostingController<AnyView> {
    private var style: FullScreenCoverStyle
    private var configuration: PresentationConfiguration
    
    init(style: FullScreenCoverStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        super.init(rootView: configuration.content)
        modalPresentationStyle = .overFullScreen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateStyle()
    }
    
    public func update(style: FullScreenCoverStyle, configuration: PresentationConfiguration) {
        self.style = style
        self.configuration = configuration
        self.rootView = configuration.content
        updateStyle()
    }
    
    private func updateStyle() {
        if let backgroundColor = style.backgroundColor, view.backgroundColor != backgroundColor {
            view.backgroundColor = backgroundColor
        }
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension PresentationStyle where Self == FullScreenCoverStyle {
    /// A presentation style that covers the underlying content.
    ///
    /// Note that you should only use SwiftUIPresent's fullScreenCover style if the native SwiftUI `fullScreenCover` modifier doesn't meet your needs.
    static var fullScreenCover: FullScreenCoverStyle {
        FullScreenCoverStyle()
    }
}
