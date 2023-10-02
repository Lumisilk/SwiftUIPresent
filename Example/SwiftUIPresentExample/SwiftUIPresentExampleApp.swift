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
                    NavigationLink("Sheet") {
                        SheetExample()
                    }
                    
                    NavigationLink("Fade") {
                        FadeExample()
                    }
                    
                    NavigationLink("Popover") {
                        PopoverExample()
                    }
                    
                    NavigationLink("Navigation") {
                        NavigationExample()
                    }
                    .isDetailLink(false)
                }
                .navigationTitle(Text("SwiftUIPresent"))
            }
        }
    }
}
