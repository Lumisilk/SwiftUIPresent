//
//  NavigationExample.swift
//  SwiftUIPresentExample
//
//  Created by Lumisilk on 2023/10/02.
//

import SwiftUI

struct NavigationExample: View {
    
    @State private var isDetailed = false
    @State private var item: MyItem?
    
    @State private var is1stSheet = false
    @State private var is2ndSheetPresented = false
    
    var body: some View {
        List {
            NavigationLink("Push", isActive: $isDetailed) {
                Button("Present sheet on this detail view") {
                    item = MyItem(value: "First String")
                }
                .present(item: $item, style: .sheet) { item in
                    Button("Pop and dismiss sheet at the same time") {
                        isDetailed = false
                        self.item = nil
                    }
                }
            }
            
            Button("Present 1st sheet \nby using SwiftUI's sheet") {
                is1stSheet = true
            }
            .sheet(isPresented: $is1stSheet) {
                Button("Present 2nd sheet \nby using SwiftUIPresent's sheet") {
                    is2ndSheetPresented = true
                }
                .present(isPresented: $is2ndSheetPresented, style: .sheet) {
                    Button("dismiss 1st and 2nd sheet at the same time") {
                        is1stSheet = false
                        is2ndSheetPresented = false
                    }
                }
            }
        }
        .navigationTitle(Text("Navigation"))
    }
}

struct NavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationExample()
    }
}
