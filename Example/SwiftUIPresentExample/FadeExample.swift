//
//  FadeExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI

struct FadeExample: View {
    
    @State private var isFadePresented = false
    @State private var useDimmingBackground = true
    
    var body: some View {
        List {
            Section {
                Toggle("Use dimming background", isOn: $useDimmingBackground)
                
                Button {
                    isFadePresented = true
                } label: {
                    StatusRow("Fade", isFadePresented)
                }
                .present(
                    isPresented: $isFadePresented,
                    style: useDimmingBackground ? .fade.backgroundColor(.black.withAlphaComponent(0.4)) : .fade
                ) {
                    VStack(spacing: 8) {
                        Sample.text
                        Button("Dismiss") {
                            isFadePresented = false
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(8)
                    .padding()
                }
            } footer: {
                Text("When using fade style, it's your responsbility to set backgorund color and dismiss programmatically.")
            }
        }
        .navigationTitle(Text("Fade"))
    }
}

struct FadeExample_Previews: PreviewProvider {
    static var previews: some View {
        FadeExample()
    }
}
