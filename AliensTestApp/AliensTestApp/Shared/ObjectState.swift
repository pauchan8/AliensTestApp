//
//  ObjectState.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 05.07.2021.
//

enum ObjectState<Value: Equatable>: Equatable {
    case loading
    case value(Value?)
    
    static func == (lhs: ObjectState<Value>, rhs: ObjectState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.value(let l), .value(let r)): return l == r
        default: return false
        }
    }
}
