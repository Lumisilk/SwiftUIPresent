//
//  Helper.swift
//  
//
//  Created by ribilynn on 2023/10/03.
//

import SwiftUI

extension Binding {
    func convertToBool<Item>() -> Binding<Bool> where Self == Binding<Optional<Item>> {
        Binding<Bool>.init(
            get: { self.wrappedValue != nil },
            set: { if $0 == false { self.wrappedValue = nil } }
        )
    }
}
