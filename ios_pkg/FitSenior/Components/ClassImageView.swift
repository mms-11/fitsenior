import SwiftUI

struct ClassImageView: View {
    let imageName: String?
    
    @ViewBuilder
    var body: some View {
        if let imageName = imageName, let image = UIImage(named: imageName) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            // Fallback usando cores nativas do SwiftUI quando não há imagem
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.teal.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundColor(.white.opacity(0.7))
            )
        }
    }
}

