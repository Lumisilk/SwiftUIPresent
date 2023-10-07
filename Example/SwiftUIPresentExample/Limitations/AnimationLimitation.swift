//
//  AnimationLimitation.swift
//  SwiftUIPresentExample
//
//  Created by ribilynn on 2023/10/07.
//

import SwiftUI

struct AnimationLimitation: View {
    
    @State private var isOfficialPresented = false
    @State private var isSheetPresented = false
    @State private var flag = false
    
    var body: some View {
        List {
            Button {
                isOfficialPresented = true
            } label: {
                StatusRow("SwiftUI official sheet", isOfficialPresented)
            }
            .sheet(isPresented: $isOfficialPresented) {
                presentedContent
            }
            
            Button {
                isSheetPresented = true
            } label: {
                StatusRow("SwiftUIPresent's sheet", isSheetPresented)
            }
            .present(isPresented: $isSheetPresented, style: .sheet) {
                presentedContent
            }
            
            Text("""
            withAnimation on presented content won't work.
                 
            Use animation modifier instead.
            """)
        }
    }
    
    private var presentedContent: some View {
        VStack {
            (flag ? Color.red: Color.green)
                .frame(width: 50, height: 50)
            
            Button("Toggle Color `withAnimation`") {
                withAnimation {
                    flag.toggle()
                }
            }
            
            (flag ? Color.red: Color.green)
                .frame(width: 50, height: 50)
                .animation(.default, value: flag)
            
            Button("Toggle Color without `withAnimation` \nbut animation modifier") {
                flag.toggle()
            }
        }
    }
}

#Preview {
    AnimationLimitation()
}
