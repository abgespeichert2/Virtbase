//
//  Upstream.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import Combine

struct Upstream {
    static let refreshed = PassthroughSubject<Void, Never>()
    
    static func refresh() {
        refreshed.send()
    }
    
    private init() {}
}
