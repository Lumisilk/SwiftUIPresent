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
    
    @Published private var configurations: [AnyHashable: PresentationConfiguration] = [:]
    private var styles: [AnyHashable: any PresentationStyle] = [:]
    
    private var presentingID: AnyHashable?
    private var cancellable: AnyCancellable?
    
    @Published private var isAppeared = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = .zero
        view.backgroundColor = nil
        view.isUserInteractionEnabled = false
        
        cancellable = $configurations
            .combineLatest($isAppeared)
            .throttle(
                for: RunLoop.main.minimumTolerance,
                scheduler: RunLoop.main,
                latest: true
            )
            .sink { [unowned self] newConfigs, isAppeared in
                if isAppeared {
                    self.updatePresentation(newConfigs)
                }
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isAppeared = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isAppeared = false
    }
    
    func register(configuration: PresentationConfiguration, style: some PresentationStyle) {
        configurations[configuration.id] = configuration
        styles[configuration.id] = style
    }
    
    func remove(id: AnyHashable) {
        if configurations[id] != nil {
            configurations[id] = nil
        }
    }
    
    private func updatePresentation(_ configurations: [AnyHashable: PresentationConfiguration]) {
        // There's presenting content currently
        if let presentingID, let presentedViewController {
            // Update current content
            if let config = configurations[presentingID], let style = styles[presentingID] {
                style.update(presentedViewController, configuration: config)
            
            // Dismiss current presented content then present another one
            } else if let (id, config) = configurations.first, let style = styles[id] {
                dismiss(animated: !config.transaction.disablesAnimations) {
                    let hostingController = style.makeHostingController(config)
                    self.presentingID = id
                    self.present(hostingController, animated: !config.transaction.disablesAnimations)
                }
            
            // Dismiss current content
            } else {
                self.presentingID = nil
                dismiss(animated: true)
            }
            
        // Present new content
        } else if let (id, config) = configurations.first, let style = styles[id] {
            let hostingController = style.makeHostingController(config)
            presentingID = id
            present(hostingController, animated: !config.transaction.disablesAnimations)
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
