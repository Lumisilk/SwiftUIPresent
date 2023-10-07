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
                    }
                    
                    Section("Special") {
                        NavigationLink("Navigation") {
                            NavigationExample()
                        }
                        .isDetailLink(false)
                    }
                    
                    Section("Custom style example") {
                        NavigationLink("TipView") {
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
                    }
                }
                .navigationTitle(Text("SwiftUIPresent"))
            }
            .navigationViewStyle(.stack)
        }
    }
}
