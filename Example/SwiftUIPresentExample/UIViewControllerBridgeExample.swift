//
//  UIViewControllerBridgeExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/17.
//

import UIKit
import SwiftUI

struct UIViewControllerBridgeExample: View {
    
    @State private var isPresented = false
    @State private var item: MyItem?
    
    var body: some View {
        List {
            Button {
                isPresented = true
            } label: {
                StatusRow("Present UIViewController", isPresented)
            }
            
            Button {
                item = MyItem(value: "My String")
            } label: {
                StatusRow("Present Item", item != nil)
            }
        }
        .navigationTitle(Text("UIViewController Bridge"))
        .presentViewController(
            isPresented: $isPresented,
            SampleViewController(dismissAction: { isPresented = false })
        )
        .presentViewController(item: $item) { item in
            SampleViewController(text: item.value, dismissAction: { self.item = nil })
        }
    }
}

private final class SampleViewController: UIViewController {
    
    let text: String?
    let dismissAction: () -> Void
    
    init(text: String? = nil, dismissAction: @escaping () -> Void) {
        self.text = text
        self.dismissAction = dismissAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        let button = UIButton(type: .system)
        button.setTitle(text ?? "Dismiss", for: .normal)
        button.addTarget(self, action: #selector(onDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func onDismiss() {
        dismissAction()
    }
}

struct UIViewControllerBridgeExample_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerBridgeExample()
    }
}
