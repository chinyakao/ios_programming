//
//  EPoint.swift
//  spritekit_cat
//
//  Created by mac23 on 2020/4/15.
//  Copyright © 2020 mac23. All rights reserved.
//

import SpriteKit

enum pointtype: Int {
    case gray = 0
    case red = 1
}

class EPoint: SKSpriteNode {
    var prePointIndex = -1
    var aroundPoint = [Int]()
    var step = 99
    var index = 0
    var type = pointtype.gray
    var isEdge = false
}
