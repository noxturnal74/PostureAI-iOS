import SwiftUI

enum Spacing {
    static let none: CGFloat = 0
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 48
    static let huge: CGFloat = 64
}

enum CornerRadius {
    static let none: CGFloat = 0
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let full: CGFloat = 9999
}

extension View {
    func standardPadding() -> some View {
        padding(.horizontal, Spacing.lg)
            .padding(.vertical, Spacing.md)
    }
    
    func card() -> some View {
        padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(CornerRadius.lg)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}
