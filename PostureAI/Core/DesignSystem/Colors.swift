import SwiftUI

// MARK: - Color Palette
// Apple HIG compliant color system
// Supports light and dark mode

struct DesignColors {
    static let accent = Color(\"AccentColor\")
    static let background = Color(\"Background\")
    static let secondaryBackground = Color(\"SecondaryBackground\")
    static let surface = Color(\"Surface\")
    static let secondarySurface = Color(\"SecondarySurface\")
    static let textPrimary = Color(\"TextPrimary\")
    static let textSecondary = Color(\"TextSecondary\")
    static let textMuted = Color(\"TextMuted\")
    static let border = Color(\"Border\)
    static let separator = Color(\"Separator\")
    static let success = Color(\"Success\")
    static let warning = Color(\"Warning\")
    static let error = Color(\"Error\")
    static let info = Color(\"Info\")
}

// MARK: - Semantic Colors

extension Color {
    static let accent = DesignColors.accent
    static let background = DesignColors.background
    static let secondaryBackground = DesignColors.secondaryBackground
    static let surface = DesignColors.surface
    static let secondarySurface = DesignColors.secondarySurface
    static let textPrimary = DesignColors.textPrimary
    static let textSecondary = DesignColors.textSecondary
    static let textMuted = DesignColors.textMuted
    static let border = DesignColors.border
    static let separator = DesignColors.separator
}

// MARK: - Exercise Colors

enum ExerciseColor {
    case squat, pushUp, bicepCurl, dumbbellFly, dumbbellKickback, plank
    
    var color: Color {
        switch self {
        case .squat: return Color(hex: \"#FF6B6B\")
        case .pushUp: return Color(hex: \"#4ECDC4\")
        case .bicepCurl: return Color(hex: \"#45B7D1\")
        case .dumbbellFly: return Color(hex: \"#96CEB4\")
        case .dumbbellKickback: return Color(hex: \"#FFEAA7\")
        case .plank: return Color(hex: \"#DDA0DD\")
        }
    }
}

// MARK: - Helper Extensions

extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        guard hex.count == 6 else { return nil }
        Scanner(string: hex).scanHexInt64(&int)
        let alpha = CGFloat(1.0)
        let red = CGFloat((int >> 16) & 0xFF) / 255.0
        let green = CGFloat((int >> 8) & 0xFF) / 255.0
        let blue = CGFloat(int & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, alpha: alpha)
    }
}
