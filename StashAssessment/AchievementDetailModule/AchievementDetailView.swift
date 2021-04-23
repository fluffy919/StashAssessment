//
//  AchievementDetailView.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI

struct AchievementDetailView: View {
    
    @ObservedObject var presenter: AchievementDetailPresenter
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            if imageLoader.image != nil {
                AchieveImage(images: self.imageLoader.image)
                    .aspectRatio(contentMode: .fit)
            }
        }.onAppear() {
            if let url = URL(string: self.presenter.achievement.bg_image_url) {
                self.imageLoader.downloadImage(url: url)
            }
        }
        .navigationBarTitle(Text(self.presenter.achievement.level), displayMode: .inline)
    }
}

struct AchievementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let achievement = model.achievements[1]
        let presenter = AchievementDetailPresenter(interactor:
            AchievementDetailInteractor(
                achievement: achievement,
                model: model))
        return NavigationView {
            AchievementDetailView(presenter: presenter)
        }
    }
}
