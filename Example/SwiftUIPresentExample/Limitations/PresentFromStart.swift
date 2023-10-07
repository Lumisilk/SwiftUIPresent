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
                    Sample.text.padding()
                }
            }
            
            Text("""
            Setting isPresented to true from the start with popover style may not work correctly.
            
            Try delaying the assignment of isPresented by using onAppear with Task or DispatchQueue.
            """)
        }
    }
}

struct PresentFromStart_Previews: PreviewProvider {
    static var previews: some View {
        PresentFromStart()
    }
}
