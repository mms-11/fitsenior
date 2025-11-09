import SwiftUI

/// Cores do tema FitSenior - versão alternativa para garantir compilação
struct ThemeColors {
    // Primary: Teal/Verde (HSL 165 70% 45%)
    static let primary = Color(red: 0.0, green: 0.7, blue: 0.6)
    static let primaryLight = Color(red: 0.2, green: 0.8, blue: 0.7)
    static let primaryDark = Color(red: 0.0, green: 0.5, blue: 0.4)
    
    // Secondary: Laranja (HSL 25 90% 60%)
    static let secondary = Color(red: 1.0, green: 0.6, blue: 0.3)
    static let secondaryLight = Color(red: 1.0, green: 0.7, blue: 0.4)
    static let secondaryDark = Color(red: 0.9, green: 0.5, blue: 0.2)
    
    // Accent: Teal claro para backgrounds
    static let accent = Color(red: 0.95, green: 0.98, blue: 0.97)
    
    // Gradients
    static let gradientPrimaryStart = Color(red: 0.0, green: 0.7, blue: 0.6)
    static let gradientPrimaryEnd = Color(red: 0.2, green: 0.8, blue: 0.7)
    
    static let gradientSecondaryStart = Color(red: 1.0, green: 0.6, blue: 0.3)
    static let gradientSecondaryEnd = Color(red: 1.0, green: 0.7, blue: 0.4)
}

/// Extensão para cores do tema FitSenior - garantindo disponibilidade
extension Color {
    // Primary: Teal/Verde (HSL 165 70% 45%)
    static var primaryFitSenior: Color {
        ThemeColors.primary
    }
    static var primaryLight: Color {
        ThemeColors.primaryLight
    }
    static var primaryDark: Color {
        ThemeColors.primaryDark
    }
    
    // Secondary: Laranja (HSL 25 90% 60%)
    static var secondaryFitSenior: Color {
        ThemeColors.secondary
    }
    static var secondaryLight: Color {
        ThemeColors.secondaryLight
    }
    static var secondaryDark: Color {
        ThemeColors.secondaryDark
    }
    
    // Accent: Teal claro para backgrounds
    static var accentFitSenior: Color {
        ThemeColors.accent
    }
    
    // Gradients
    static var gradientPrimaryStart: Color {
        ThemeColors.gradientPrimaryStart
    }
    static var gradientPrimaryEnd: Color {
        ThemeColors.gradientPrimaryEnd
    }
    
    static var gradientSecondaryStart: Color {
        ThemeColors.gradientSecondaryStart
    }
    static var gradientSecondaryEnd: Color {
        ThemeColors.gradientSecondaryEnd
    }
}

