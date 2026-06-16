import SwiftUI

extension UIColor {
    convenience init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        guard hex.count == 6 else { return nil }
        Scanner(string: hex).scanHexInt64(&int)
        let alpha = CGFloat(1.0)
        let red = CGFloat((int >> 16) & 0xFF) / 255.0
        let green = CGFloat((int >> 8) & 0xFF) / 255.0
        let blue = CGFloat(int & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    static let accent = Color(hex: \"#3B82F6\")
    static let background = Color(hex: \"#F9FAFB\")
    static let secondaryBackground = Color(hex: \"#F3F4F6\")
    static let surface = Color(hex: \"#FFFFFF\")
    static let textPrimary = Color(hex: \"#111827\")
    static let textSecondary = Color(hex: \"#6B7280\")
    static let textMuted = Color(hex: \"#9CA3AF\")
    static let border = Color(hex: \"#E5E7EB\")
    static let separator = Color(hex: \"#E5E7EB\")
    static let success = Color(hex: \"#10B981\")
    static let warning = Color(hex: \"#F59E0B\")
    static let error = Color(hex: \"#EF4444\")
    static let info = Color(hex: \"#3B82F6\")
}
