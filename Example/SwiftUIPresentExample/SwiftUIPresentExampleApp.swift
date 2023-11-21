//
//  SwiftUIPresentExampleApp.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/09/28.
//

import SwiftUI

@main
struct SwiftUIPresentExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Section("Styles") {
                        NavigationLink("Sheet") {
                            SheetExample()
                        }
                        
                        NavigationLink("Fade") {
                            FadeExample()
                        }
                        
                        NavigationLink("Popover") {
                            PopoverExample()
                        }
                        
                        NavigationLink("FullScreenOver") {
                            FullScreenCoverExample()
                        }
                        
                        NavigationLink("UIViewControllerBridge") {
                            UIViewControllerBridgeExample()
                        }
                    }
                    
                    Section("Special") {
                        NavigationLink("Navigation") {
                            NavigationExample()
                        }
                        .isDetailLink(false)
                        
                        NavigationLink("Custom style example") {
                            TipExample()
                        }
                    }
                    
                    Section("Limitation") {
                        NavigationLink("Implicit value passing") {
                            ImplicitValuePassing()
                        }
                        NavigationLink("Animation") {
                            AnimationLimitation()
                        }
                        NavigationLink("Present from the start") {
                            PresentFromStart()
                        }
                    }
                }
                .navigationTitle(Text("SwiftUIPresent"))
            }
            .navigationViewStyle(.stack)
        }
    }
}
