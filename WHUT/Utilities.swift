//
//  Utilities.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI

let screen = UIScreen.main.bounds

func getCardWidth() -> CGFloat {
    if screen.width > 712 {
        return 712
    }
    return screen.width - 60
}

func getCardHeight() -> CGFloat {
    if screen.width > 712 {
        return 80
    }
    return 280
}

func getAngleMultiplier() -> Double {
    if screen.width > 500 {
        return 80
    } else {
        return 20
    }
}
