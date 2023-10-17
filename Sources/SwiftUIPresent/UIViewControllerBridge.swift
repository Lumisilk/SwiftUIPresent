//
//  SwiftUIView.swift
//  
//
//  Created by Lumisilk on 2023/10/17.
//

import SwiftUI

private struct UIViewControllerBridgeStyle<ViewController: UIViewController>: PresentationStyle {
    let viewController: ViewController
    
    func makeHostingController(_ configuration: PresentationConfiguration) -> ViewController {
        viewController
    }
    
    func update(_ hostingController: ViewController, configuration: PresentationConfiguration) {}
}

private struct ItemUIViewControllerBridgeStyle<Item: Identifiable>: PresentationStyle {
    @Binding var item: Item?
    let viewController: (Item) -> UIViewController
    
    func makeHostingController(_ configuration: PresentationConfiguration) -> UIViewController {
        if let item {
            return viewController(item)
        } else {
            assertionFailure("Should not reach here.")
            return UIViewController()
        }
    }
    
    func update(_ hostingController: UIViewController, configuration: PresentationConfiguration) {}
}

public extension View {
    /// Present a UIViewController.
    ///
    /// - Parameters:
    ///   - viewController: The view controlelr to present.
    ///   - isPresented: A binding to a Boolean value that determines whether to present the view controller you create.
    func presentViewController(isPresented: Binding<Bool>, _ viewController: UIViewController) -> some View {
        modifier(
            BoolPresentationModifier(
                isPresented: isPresented,
                style: UIViewControllerBridgeStyle(viewController: viewController),
                presentContent: EmptyView()
            )
        )
    }
    
    /// Presents a UIViewController using the given item as a data source for the view controller's content.
    /// 
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the presented view controller. When item is non-nil, SwiftUIPresent passes the item’s content to the modifier’s closure.
    ///   You display this content in the presented view controller that you create that the system displays to the user. If item changes, SwiftUIPresent dismisses the view controller and replaces it with a new one using the same process.
    ///   - viewController: A closure that returns the view controller to be presented.
    func presentViewController<Item: Identifiable>(item: Binding<Item?>, _ viewController: @escaping (Item) -> UIViewController) -> some View {
        modifier(
            ItemPresentationModifier(
                item: item,
                style: ItemUIViewControllerBridgeStyle(item: item, viewController: viewController),
                presentContent: { _ in EmptyView() }
            )
        )
    }
}
