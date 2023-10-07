//
//  ImplicitValuePassing.swift
//  SwiftUIPresentExample
//
//  Created by ribilynn on 2023/10/04.
//

import SwiftUI

struct ImplicitValuePassing: View {
    
    @State var isPresented = false
    
    var body: some View {
        List {
            Section {
                Button {
                    isPresented = true
                } label: {
                    StatusRow("Environment", isPresented)
                }
                .present(
                    isPresented: $isPresented,
                    style: .fade(backgroundColor: .black.withAlphaComponent(0.4))
                ) {
                    Button("Dismiss") {
                        isPresented = false
                    }
                    .padding()
                    .background(Color.white)
                    .navigationTitle(Text("Navigation Title")) // This doesn't work.
                }
                .font(.largeTitle) // This doesn't work.
            } footer: {
                Text("""
                The larger font size isn't passed to the lower heirarchy (the presented content) via environment implicitly.
                And the navigation title in presented content isn't passed to the upper heirarchy via preference implicitly.
                """)
            }
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
