//
//  PresentationCoordinator.swift
//
//
//  Created by Lumisilk on 2023/09/28.
//

import Combine
import UIKit
import SwiftUI

final class PresentationCoordinator: UIViewController {
    
    @Published private var configurations: [Namespace.ID: PresentationConfiguration] = [:]
    private var styles: [Namespace.ID: any PresentationStyle] = [:]
    
    private var presentingID: Namespace.ID?
    private var hostingController: UIViewController?
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = .zero
        view.backgroundColor = nil
        view.isUserInteractionEnabled = false
        
        cancellable = $configurations
            .throttle(
                for: RunLoop.main.minimumTolerance,
                scheduler: RunLoop.main,
                latest: true
            )
            .sink { [unowned self] in
                self.updatePresentation($0)
            }
    }
    
    func register(configuration: PresentationConfiguration, style: some PresentationStyle) {
        configurations[configuration.id] = configuration
        styles[configuration.id] = style
    }
    
    func remove(id: Namespace.ID) {
        configurations.removeValue(forKey: id)
    }
    
    private func updatePresentation(_ configurations: [Namespace.ID: PresentationConfiguration]) {
        // There's presenting content currently
        if let presentingID, let hostingController {
            // Update current content
            if let config = configurations[presentingID], let style = styles[presentingID] {
                style.update(hostingController, configuration: config)
            
            // Dismiss current presented content then present another one
            } else if let (id, config) = configurations.first, let style = styles[id] {
                dismiss(animated: !config.transaction.disablesAnimations) {
                    self.hostingController = style.makeHostingController(config)
                    self.presentingID = id
                    self.present(self.hostingController!, animated: !config.transaction.disablesAnimations)
                }
            
            // Dismiss current content
            } else {
                self.presentingID = nil
                dismiss(animated: true)
            }
            
        // Present new content
        } else if let (id, config) = configurations.first, let style = styles[id] {
            hostingController = style.makeHostingController(config)
            presentingID = id
            present(hostingController!, animated: !config.transaction.disablesAnimations)
        }
    }
}

extension UIViewController {
    var presentationCoordinator: PresentationCoordinator {
        for child in children {
            if let coordinator = child as? PresentationCoordinator {
                return coordinator
            }
        }

        let coordinator = PresentationCoordinator()
        addChild(coordinator)
        view.insertSubview(coordinator.view, at: 0)
        coordinator.didMove(toParent: self)
        return coordinator
    }
}
