//
//  Profile.swift
//  Landmarks
//
//  Created by 이다영 on 2021/08/31.
//

import Foundation

struct Profile {
    var username: String
    var preferNotification = true
    var seasonalPhoto = Season.autumn
    var goalDate = Date()
    
    static let `default` = Profile(username: "dayeong")
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        var id: String { self.rawValue }
    }
}
