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
            
            Text("""
            The larger font size isn't passed to the lower hierarchy (the presented content) via the environment implicitly.
            
            And the navigation title set on the presented content isn't passed to the upper hierarchy via preference implicitly.
            """)
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
