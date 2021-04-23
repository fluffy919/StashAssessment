//
//  ContentView.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: DataModel
    
    var body: some View {
        NavigationView {
            AchievementListView(presenter:
                AchievementListPresenter(interactor:
                    AchievementListInteractor(model: model)))
        }
//        .padding(.trailing, -32.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        return ContentView()
          .environmentObject(model)
    }
}
