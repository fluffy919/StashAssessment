//
//  AchievementDetailInteractor.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import Combine

class AchievementDetailInteractor {
    
    @Published var achievement: Achievement
    private let model: DataModel
    private var cancellables = Set<AnyCancellable>()
    
    init (achievement: Achievement, model: DataModel) {
        self.achievement = achievement
        self.model = model
    }

}
