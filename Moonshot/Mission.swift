//
//  Mission.swift
//  Moonshot
//
//  Created by Martin Lopez Uribe on 17/12/20.
//

import Foundation



struct Mission: Identifiable, Codable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let description: String
    let crew: [CrewRole]
    let launchDate: Date?
    
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
