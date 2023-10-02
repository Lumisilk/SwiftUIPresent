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
                    Section {
                        NavigationLink("Sheet") {
                            SheetExample()
                        }
                        
                        NavigationLink("Fade") {
                            FadeExample()
                        }
                        
                        NavigationLink("Popover") {
                            PopoverExample()
                        }
                    } header: {
                        Text("Styles")
                    }
                    
                    Section {
                        NavigationLink("Navigation") {
                            NavigationExample()
                        }
                        .isDetailLink(false)
                    } header: {
                        Text("Special")
                    }
                }
                .navigationTitle(Text("SwiftUIPresent"))
            }
        }
    }
}
