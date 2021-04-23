//
//  AchievementDetailPresenter.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI
import Combine

class AchievementDetailPresenter: ObservableObject {
    
    private let interactor: AchievementDetailInteractor
    private let router: AchievementDetailRouter
    private var cancellables = Set<AnyCancellable>()
    @Published var achievement: Achievement = Achievement()

    init(interactor: AchievementDetailInteractor) {
        self.interactor = interactor
        self.router = AchievementDetailRouter()
    
        interactor.$achievement
            .assign(to: \.achievement, on: self)
            .store(in: &cancellables)
    }
}
