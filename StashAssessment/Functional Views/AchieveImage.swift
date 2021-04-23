//
//  SplitImage.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import SwiftUI

struct AchieveImage: View {
    
    var images: UIImage?

    func image(for uiImage: UIImage) -> some View {
        return Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    var body: some View {
        
        return AnyView(image(for: images!))

    }
}

struct AchieveImage_Previews: PreviewProvider {
    static var previews: some View {
        AchieveImage(images: UIImage(named: "empty")!)
            .frame(height: 100)
    }
}
