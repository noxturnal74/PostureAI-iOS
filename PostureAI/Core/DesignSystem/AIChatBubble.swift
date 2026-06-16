import SwiftUI

struct AIChatBubble: View {
    let message: String
    let isUser: Bool
    let timestamp: Date
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !isUser {
                Image(systemName: "sparkles")
                    .font(.caption)
                    .foregroundColor(.accent)
            }
            
            Text(message)
                .font(.callout)
                .foregroundColor(isUser ? .white : .textPrimary)
                .padding(Spacing.md)
                .background(isUser ? Color.accent : Color.secondarySurface)
                .cornerRadius(isUser ? CornerRadius.md : CornerRadius.md)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: isUser ? .trailing : .leading)
            
            if isUser {
                Image(systemName: "person")
                    .font(.caption)
                    .foregroundColor(.textMuted)
            }
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, 4)
    }
}

struct AIChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 8) {
            AIChatBubble(message: \"Hello! I'm your AI fitness coach. Let's get started!\", isUser: false, timestamp: Date())
            AIChatBubble(message: \"I'm ready when you are!\", isUser: true, timestamp: Date())
        }
        .background(Color.secondaryBackground)
        .previewLayout(.sizeThatFits)
    }
}
