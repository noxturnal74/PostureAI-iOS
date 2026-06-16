import SwiftUI

struct CardView: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(CornerRadius.lg)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            VStack(spacing: Spacing.md) {
                Text(\"Card Title\")
                    .headline()
                Text(\"Card content goes here.\")
                    .body()
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
