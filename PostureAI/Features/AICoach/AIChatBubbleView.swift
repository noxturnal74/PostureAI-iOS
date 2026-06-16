import SwiftUI
import Combine

struct AIChatBubbleView: View {
    let message: String
    let isUser: Bool
    let timestamp: Date
    let status: MessageStatus
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !isUser {
                Image(systemName: \"sparkles\")
                    .font(.caption2)
                    .foregroundColor(.accent)
            }
            
            Text(message)
                .font(.callout)
                .foregroundColor(isUser ? .white : .textPrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isUser ? Color.accent : Color.secondarySurface)
                .cornerRadius(isUser ? 12 : 12)
                .frame(maxWidth: .screenWidth * 0.75, alignment: isUser ? .trailing : .leading)
            
            if isUser {
                HStack(spacing: 4) {
                    Image(systemName: \"person\")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.8))
                    if status == .delivered {
                        Image(systemName: \"checkmark\")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.8))
                    } else if status == .read {
                        Image(systemName: \"checkmark.double\")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

enum MessageStatus {
    case sending
    case delivered
    case read
}

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.width
}

struct AIChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 8) {
            AIChatBubbleView(message: \"Hello! I'm your AI fitness coach. I can help you with proper form, rep counting, and technique improvements. What exercise are we doing today?\", isUser: false, timestamp: Date(), status: .delivered)
            AIChatBubbleView(message: \"Let's do some squats!\", isUser: true, timestamp: Date(), status: .read)
            AIChatBubbleView(message: \"Great choice! Remember to keep your feet shoulder-width apart, chest up, and knees behind your toes. I'll analyze your form in real-time.\", isUser: false, timestamp: Date(), status: .delivered)
        }
        .background(Color.secondaryBackground.ignoresSafeArea())
        .previewLayout(.sizeThatFits)
    }
}
