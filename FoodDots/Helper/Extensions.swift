//
//  Extensions.swift
//  FoodDots
//
//  Created by yanfeng liu on 6/12/21.
//

import Foundation

extension Double {
    
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
