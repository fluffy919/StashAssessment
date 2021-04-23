//
//  AchievementListView.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI

struct AchievementListView: View {
    
    @ObservedObject var presenter: AchievementListPresenter
    
    var body: some View {
        List {
            ForEach (presenter.achievements, id: \.id) { item in
                self.presenter.linkBuilder(for: item) {
                    AchievementListCell(achievement: item)
                        .frame(height: 240)
                }
            }
        }
        .navigationBarTitle("Smart Investing", displayMode: .inline)
        .navigationBarItems(trailing:
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "exclamationmark.circle")
                                            .font(.title)
                                            .rotationEffect(.degrees(180))
                                    }.foregroundColor(.white)
                                })
    }
}

struct AchievementListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = DataModel.sample
        let interactor = AchievementListInteractor(model: model)
        let presenter = AchievementListPresenter(interactor: interactor)
        
        return NavigationView {
            AchievementListView(presenter: presenter)
        }
    }
}
