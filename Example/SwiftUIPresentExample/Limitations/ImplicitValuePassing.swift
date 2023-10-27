//
//  ImplicitValuePassing.swift
//  SwiftUIPresentExample
//
//  Created by ribilynn on 2023/10/04.
//

import SwiftUI

private enum MyPreferenceKey: PreferenceKey {
    static var defaultValue: String = "Default String"
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct ImplicitValuePassing: View {
    
    @State var isPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                isPresented = true
            } label: {
                StatusRow("Present", isPresented)
            }
            .present(
                isPresented: $isPresented,
                style: .fade.backgroundColor(.black.withAlphaComponent(0.4))
            ) {
                Button("Dismiss") {
                    isPresented = false
                }
                .padding()
                .background(Color.white)
                .preference(key: MyPreferenceKey.self, value: "Correct String") // This doesn't work.
            }
            .font(.largeTitle) // This doesn't work.
            
            Text("""
            The larger font size isn't passed to the lower hierarchy (the presented content) via the environment implicitly.
            
            And the preference value set on the presented content isn't passed to the upper hierarchy via preference.
            """)
            
            Spacer()
        }
        .padding()
        .overlayPreferenceValue(MyPreferenceKey.self, alignment: .bottom) { value in
            Text("Preference: \(value)")
        }
    }
}

struct LimitationExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ImplicitValuePassing()
        }
    }
}
