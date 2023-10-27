//
//  PresentFromStart.swift
//  SwiftUIPresentExample
//
//  Created by ribilynn on 2023/10/07.
//

import SwiftUI

struct PresentFromStart: View {
    
    @State private var isPresneted1 = false
    @State private var isPresneted2 = true
    
    var body: some View {
        List {
            Button {
                isPresneted1 = true
            } label: {
                StatusRow("1st Present", isPresneted1)
            }
            .present(isPresented: $isPresneted1, style: .sheet) {
                Button {
                    isPresneted2 = true
                } label: {
                    StatusRow("2nd Present", isPresneted2)
                }
                .present(isPresented: $isPresneted2, style: .popover) {
                    Text("This popover may appear in an incorrect position.")
                        .padding()
                }
            }
            
            Text("""
            When using the popover style, setting isPresented to true before the view has appeared may lead to incorrect behavior.
            
            Consider delaying the assignment by using `onAppear` combined with either `Task` or `DispatchQueue`.
            """)
        }
    }
}

struct PresentFromStart_Previews: PreviewProvider {
    static var previews: some View {
        PresentFromStart()
    }
}
