//
//  Profile.swift
//  Landmarks
//
//  Created by 문상우 on 2023/05/17.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goladDate = Date()
    
    static let `default` = Profile(username: "Alan Walker")
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        var id: String { rawValue }
    }
}
