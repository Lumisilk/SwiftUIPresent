//
//  PresentationStyle.swift
//  
//
//  Created by Lumisilk on 2023/09/28.
//

import UIKit
import SwiftUI

public struct PresentationConfiguration {
    public let id: AnyHashable
    public let isPresented: Binding<Bool>
    public let anchorView: UIView
    public let transaction: Transaction
    public let content: AnyView
}

public protocol PresentationStyle {
    associatedtype HostingControllerType: UIViewController
    
    func makeHostingController(_ configuration: PresentationConfiguration) -> HostingControllerType
    func update(_ hostingController: HostingControllerType, configuration: PresentationConfiguration)
}

extension PresentationStyle {
    func update(_ hostingController: UIViewController, configuration: PresentationConfiguration) {
        if let controller = hostingController as? HostingControllerType {
            update(controller, configuration: configuration)
        }
    }
}
