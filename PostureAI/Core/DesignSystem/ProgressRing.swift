import SwiftUI

struct ProgressRing: View {
    let progress: Double
    let strokeWidth: CGFloat
    let color: Color
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.border, lineWidth: strokeWidth)
            
            Circle()
                .trim(from: 0, to: min(progress, 1))
                .stroke(color, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
        .frame(width: size, height: size)
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing(progress: 0.75, strokeWidth: 8, color: .accent, size: 100)
            .previewLayout(.sizeThatFits)
    }
}
