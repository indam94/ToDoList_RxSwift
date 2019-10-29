//
//  Task.swift
//  GoodList
//
//  Created by DONGGUN LEE on 10/29/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation

enum Priority: Int{
    case high
    case medium
    case low
}

struct Task{
    let title: String
    let priority: Priority
}
