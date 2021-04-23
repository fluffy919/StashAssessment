//
//  DataModel.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import Combine

final class DataModel {
    
    private let persisitence = Persistence()
    private var cancellables = Set<AnyCancellable>()
    @Published var achievements: [Achievement] = []
    
    func load() {
        persisitence.load()
            .assign(to: \.achievements, on: self)
            .store(in: &cancellables)
    }
    
    func loadDefault(synchronous: Bool = false) {
        persisitence.loadDefault(synchronous: synchronous)
            .assign(to: \.achievements, on: self)
            .store(in: &cancellables)
    }
    
    func removeAchievement(achievement: Achievement) {
        achievements.removeAll() { $0.id == achievement.id }
    }
}

extension DataModel: ObservableObject {}

/// Extension for SwiftUI previews
#if DEBUG
extension DataModel {
    static var sample: DataModel {
        let model = DataModel()
        model.loadDefault(synchronous: true)
        return model
    }
}
#endif
