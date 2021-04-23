//
//  Achievement.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import Foundation
import Combine

final class Achievement {
  
    let level: String
    var progress: Float
    var total: Float
    let bg_image_url: String
    var accessible: Bool
    let id: Int

    init() {
        id = Int()
        progress = Float()
        total = Float()
        accessible = Bool()
        bg_image_url = String()
        level = String()
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        level = try container.decode(String.self, forKey: .level)
        id = try container.decode(Int.self, forKey: .id)
        progress = try container.decode(Float.self, forKey: .progress)
        total = try container.decode(Float.self, forKey: .total)
        bg_image_url = try container.decode(String.self, forKey: .bg_image_url)
        accessible = try container.decode(Bool.self, forKey: .accessible)
    }

}

extension Achievement: Codable {
    enum CodingKeys: CodingKey {
        case id
        case level
        case progress
        case total
        case bg_image_url
        case accessible
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(level, forKey: .level)
        try container.encode(progress, forKey: .progress)
        try container.encode(total, forKey: .total)
        try container.encode(bg_image_url, forKey: .bg_image_url)
        try container.encode(accessible, forKey: .accessible)
    }
}

extension Achievement: Equatable {
    static func == (lhs: Achievement, rhs: Achievement) -> Bool {
        lhs.id == rhs.id
    }
}

extension Achievement: Identifiable {}

extension Achievement: ObservableObject {}
