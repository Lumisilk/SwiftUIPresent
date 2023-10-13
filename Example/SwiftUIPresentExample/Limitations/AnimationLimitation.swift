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
    @State private var isExtractedPresented = false
    @State private var flag = false
    
    var body: some View {
        List {
            Button {
                isOfficialPresented = true
            } label: {
                StatusRow("SwiftUI official sheet (correct)", isOfficialPresented)
            }
            .sheet(isPresented: $isOfficialPresented) {
                exmapleView(flag: $flag)
            }
            
            Button {
                isSheetPresented = true
            } label: {
                StatusRow("SwiftUIPresent's sheet (wrong)", isSheetPresented)
            }
            .present(isPresented: $isSheetPresented, style: .sheet) {
                exmapleView(flag: $flag)
            }
            
            Text("""
            When the value that triggers the animation lies outside of the content view closure, `withAnimation(_:_:)` won't have an effect on the presented content.
            
            Instead, use the `animation(_:value:)` modifier or extract the content into a separate view that holds the relevant properties.
            """)
            
            Button {
                isExtractedPresented = true
            } label: {
                StatusRow("Extracted view (correct)", isExtractedPresented)
            }
            .present(isPresented: $isExtractedPresented, style: .sheet) {
                ExtractedView()
            }
        }
    }
}

private struct ExtractedView: View {
    @State private var flag = false
    
    var body: some View {
        exmapleView(flag: $flag)
    }
}

private func exmapleView(flag: Binding<Bool>) -> some View {
    VStack {
        Color.green
            .frame(width: 50, height: 50)
            .frame(maxWidth: .infinity, alignment: flag.wrappedValue ? .trailing: .leading)
        
        Button("Toggle `withAnimation`") {
            withAnimation {
                flag.wrappedValue.toggle()
            }
        }
        
        Color.green
            .frame(width: 50, height: 50)
            .frame(maxWidth: .infinity, alignment: flag.wrappedValue ? .trailing: .leading)
            .animation(.default, value: flag.wrappedValue)
        
        Button("Toggle without `withAnimation` \nbut animation modifier") {
            flag.wrappedValue.toggle()
        }
    }
    .padding()
}

struct AnimationLimitation_Previews: PreviewProvider {
    static var previews: some View {
        AnimationLimitation()
    }
}
