//
//  Even.swift
//  Unit test Sample
//
//  Created by 문상우 on 2023/06/23.
//

import Foundation

struct Even {
    let number: Int
    var isEven: Bool {
        get {
            return number % 2 == 0
        }
    }
}
