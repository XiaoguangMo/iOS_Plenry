//
//  Color.swift
//  Plenry
//
//  Created by NNNO on 7/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

let ColorGreen:UIColor = UIColor(red: 0.40, green: 0.77, blue: 0.49, alpha: 1.0)
let ColorSuperLightGrey = UIColor(white: 0.97, alpha: 1)
let ColorLightGrey = UIColor(white: 0.93, alpha: 1)
let ColorDarkGrey = UIColor(white: 0.8, alpha: 1)
let ColorGold = UIColor(red: 0.99, green: 0.76, blue: 0.16, alpha: 1.0)
let ColorOpacityTwoGreen = UIColor(red: 0.47, green: 0.79, blue: 0.57, alpha: 0.3)
let ColorOpacityFourGreen = UIColor(red: 0.47, green: 0.79, blue: 0.57, alpha: 0.6)
let ColorRed = UIColor(red: 0.95, green: 0.43, blue: 0.37, alpha: 1.0)
let ColorGrey = UIColor(white: 0.61, alpha: 1)
let ColorBlue = UIColor(red: 0, green: 0.65, blue: 0.83, alpha: 1.0)
let ColorBrown = UIColor(red: 0.69, green: 0.50, blue: 0.42, alpha: 1.0)

func getRatingImage(rating:Float) -> UIImage {
    if rating<0.5{
        return UIImage(named: "0.0_star")!
    }else if rating < 1.0 {
        return UIImage(named: "0.5_star")!
    }else if rating < 1.5 {
        return UIImage(named: "1.0_star")!
    }else if rating < 2.0 {
        return UIImage(named: "1.5_star")!
    }else if rating < 2.5 {
        return UIImage(named: "2.0_star")!
    }else if rating < 3.0 {
        return UIImage(named: "2.5_star")!
    }else if rating < 3.5 {
        return UIImage(named: "3.0_star")!
    }else if rating < 4.0 {
        return UIImage(named: "3.5_star")!
    }else if rating < 4.5 {
        return UIImage(named: "4.0_star")!
    }else if rating < 5.0 {
        return UIImage(named: "4.5_star")!
    }else{
        return UIImage(named: "5.0_star")!
    }
}

func rainbowColor(x :Float) -> UIColor {
    let unit:Float = 256
    var r:Float = 0, g:Float = 0, b:Float = 0
    if ( 0 <= x && x < unit) { //赤 -> 橙 -> 黄
        r = unit - 1
        g = x
    } else if (x < unit * 2) { //黄 -> 绿
        r = unit - 1 - x % unit
        g = unit - 1
    } else if (x < unit * 3) { //绿 -> 青
        g = unit - 1 - x % unit / 2
        b = x % unit
    } else if (x < unit * 4) { //青 -> 蓝
        g = unit / 2 - 1 - x % unit / 2
        b = unit - 1
    } else if (x < unit * 5) { //蓝 -> 紫
        r = x % unit
        b = unit - 1
    }
    let red = CGFloat(r/(unit-1))
    let green = CGFloat(g/(unit-1))
    let blue = CGFloat(b/(unit-1))
    return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(1.0))
}
