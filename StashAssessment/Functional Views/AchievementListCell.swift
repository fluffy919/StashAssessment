//
//  AchievementListCell.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI
import Combine

struct AchievementListCell: View {
    
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    @ObservedObject var achievement: Achievement
        
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                if imageLoader.image != nil {
                    AchieveImage(images: self.imageLoader.image)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                VStack {
                    Text("Level")
                        .font(.system(size: 24))
                    Text(self.achievement.level)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .shadow(radius: 7)
                .background(Circle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                            .opacity(0.6))
                Slider(value: $achievement.progress, in: 0...achievement.total, step: 1)
                    .accentColor(Color.green)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 30, trailing: 8))
                HStack {
                    Text("  \(Int(self.achievement.progress))pts")
                    Spacer()
                    Text("\(Int(self.achievement.total))pts  ")
                }
                .foregroundColor(Color.white)
                .font(.system(size: 24))
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 4, trailing: 8))
            }
            .cornerRadius(12)
            .shadow(radius: 7)
            if achievement.progress == 0 {
                BlurView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }.onAppear() {
            if let url = URL(string: self.achievement.bg_image_url) {
                self.imageLoader.downloadImage(url: url)
            }
        }
        .frame(minWidth:0, maxWidth: .infinity)
        .padding([.leading, .trailing], 0)
    }
}

struct AchievementListCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let achievement = model.achievements[0]
        return AchievementListCell(achievement: achievement)
            .frame(height: 160)
            .environmentObject(model)
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.6
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
    }
}
