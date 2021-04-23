//
//  AchievementListPresenter.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI
import Combine

class AchievementListPresenter: ObservableObject {
    
    private let interactor: AchievementListInteractor
    private let router = AchievementListRouter()
    private var cancellables = Set<AnyCancellable>()
  
    @Published var achievements: [Achievement] = []
  
    init(interactor: AchievementListInteractor) {
        self.interactor = interactor
    
        interactor.model.$achievements
            .assign(to: \.achievements, on: self)
            .store(in: &cancellables)
    }

    func linkBuilder<Content: View>(for achievement: Achievement, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: achievement, model: interactor.model)) {
            content()
        }
    }
}
