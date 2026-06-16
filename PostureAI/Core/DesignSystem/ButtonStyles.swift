import SwiftUI

struct ButtonStyles {
    static func primaryButton() -> some ViewStyle {
        ButtonStyle(configuration: PrimaryButtonConfiguration())
    }
    
    static func secondaryButton() -> some ViewStyle {
        ButtonStyle(configuration: SecondaryButtonConfiguration())
    }
    
    static func ghostButton() -> some ViewStyle {
        ButtonStyle(configuration: GhostButtonConfiguration())
    }
    
    static func actionButton() -> some ViewStyle {
        ButtonStyle(configuration: ActionButtonConfiguration())
    }
}

// MARK: - Primary Button

struct PrimaryButtonConfiguration: ViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, Spacing.xl)
            .padding(.vertical, Spacing.sm)
            .background(Color.accent)
            .cornerRadius(CornerRadius.md)
            .shadow(color: Color.accent.opacity(0.3), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Secondary Button

struct SecondaryButtonConfiguration: ViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.accent)
            .padding(.horizontal, Spacing.xl)
            .padding(.vertical, Spacing.sm)
            .background(Color.secondarySurface)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.accent, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Ghost Button

struct GhostButtonConfiguration: ViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subhead)
            .foregroundColor(.textPrimary)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.xs)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Action Button (Big, circular)

struct ActionButtonConfiguration: ViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .background(Color.accent)
            .cornerRadius(CornerRadius.full)
            .shadow(color: Color.accent.opacity(0.3), radius: 12, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
