//
//  UserModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation
import UIKit

enum SignType {
    case custom
    case apple
    case google
}

struct UserModel {
    var type: SignType
    var name: String
    var profile: UIImage?
    var epm: UserEpm
    var fillerWords: [String] = []
}

struct UserEpm {
    var min: Double
    var max: Double
    
    func average() -> Double {
        (min + max) / 2
    }
}
