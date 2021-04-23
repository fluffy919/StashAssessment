//
//  AchievementListRouter.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI

class AchievementListRouter {
    func makeDetailView(for achievement: Achievement, model: DataModel) -> some View {
        let presenter = AchievementDetailPresenter(interactor:
            AchievementDetailInteractor(
                achievement: achievement,
                model: model))
        return AchievementDetailView(presenter: presenter)
    }
}
