import SwiftUI

/// Extensão para cores do tema FitSenior baseadas no frontend
extension Color {
    // Primary: Teal/Verde (HSL 165 70% 45%)
    static let primaryFitSenior = Color(red: 0.0, green: 0.7, blue: 0.6)
    static let primaryLight = Color(red: 0.2, green: 0.8, blue: 0.7)
    static let primaryDark = Color(red: 0.0, green: 0.5, blue: 0.4)
    
    // Secondary: Laranja (HSL 25 90% 60%)
    static let secondaryFitSenior = Color(red: 1.0, green: 0.6, blue: 0.3)
    static let secondaryLight = Color(red: 1.0, green: 0.7, blue: 0.4)
    static let secondaryDark = Color(red: 0.9, green: 0.5, blue: 0.2)
    
    // Accent: Teal claro para backgrounds
    static let accentFitSenior = Color(red: 0.95, green: 0.98, blue: 0.97)
    
    // Gradients
    static let gradientPrimaryStart = Color(red: 0.0, green: 0.7, blue: 0.6)
    static let gradientPrimaryEnd = Color(red: 0.2, green: 0.8, blue: 0.7)
    
    static let gradientSecondaryStart = Color(red: 1.0, green: 0.6, blue: 0.3)
    static let gradientSecondaryEnd = Color(red: 1.0, green: 0.7, blue: 0.4)
}

/// View modifier para gradiente primário
struct PrimaryGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.gradientPrimaryStart, Color.gradientPrimaryEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

/// View modifier para gradiente secundário
struct SecondaryGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.gradientSecondaryStart, Color.gradientSecondaryEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

extension View {
    func primaryGradient() -> some View {
        modifier(PrimaryGradient())
    }
    
    func secondaryGradient() -> some View {
        modifier(SecondaryGradient())
    }
}

