//
//  SizeConstant.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct SizeConstant {
    
    static var screenXCutOff: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    static var screenYCutOff: CGFloat {
        (UIScreen.main.bounds.height / 2) * 0.8
    }
    
    static var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    static var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
}
