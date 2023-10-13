//
//  PresentationStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

/// Properties and details relevant to presentation.
public struct PresentationConfiguration {
    let id: AnyHashable
    
    /// A binding to a Boolean value that determines whether to present the view that you create in the modifier’s content closure.
    public let isPresented: Binding<Bool>
    
    /// The original SwiftUI view to which the presentation modifier is attached.
    public let anchorView: UIView
    
    /// The context for the current state-updating cycle, derived from UIViewRepresentable's context.
    public let transaction: Transaction
    
    /// The actual content to display, as provided within the presentation modifier.
    public let content: AnyView
}

/// A protocol defining how to present the provided content.
public protocol PresentationStyle {
    /// The type of view controller to present.
    associatedtype HostingControllerType: UIViewController
    
    /// Creates the UIKit view controller and initializes its content and presentation style.
    ///
    /// You should create a new view controller, typically a subclass of UIHostingController<AnyView>.
    /// Then, based on the information provided in the configuration, adjust its modalPresentationStyle and/or modalTransitionStyle.
    /// Finally, pass the view contents from the configuration to the view controller for display.
    ///
    /// - Parameter configuration: Properties and details relevant to presentation.
    /// - Returns: Your UIKit view configured with the provided information.
    func makeHostingController(_ configuration: PresentationConfiguration) -> HostingControllerType
    
    /// Updates the state of the specified view controller with new information.
    ///
    /// This method is called when the View Controller remains visible on the screen, but either the style or the present content has been updated. You should reflect the updated information in the view controller.
    /// - Parameters:
    ///   - hostingController: Your custom view controller.
    ///   - configuration: Properties and details relevant to presentation.
    func update(_ hostingController: HostingControllerType, configuration: PresentationConfiguration)
}

extension PresentationStyle {
    func update(_ hostingController: UIViewController, configuration: PresentationConfiguration) {
        if let controller = hostingController as? HostingControllerType {
            update(controller, configuration: configuration)
        }
    }
}
