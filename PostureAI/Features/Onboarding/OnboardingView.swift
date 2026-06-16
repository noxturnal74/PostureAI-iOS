import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showMainApp = false
    
    let pages = [
        OnboardingPage(title: \"Welcome to PostureAI\", description: \"Your AI-powered fitness coach that analyzes your form in real-time using advanced computer vision technology.\", image: \"figure.strength??\", color: .accent),
        OnboardingPage(title: \"Real-Time Feedback\", description: \"Get instant feedback on your posture and form. We'll help you avoid injuries and maximize your workouts with proper technique.\", image: \"eye.fill\", color: .info),
        OnboardingPage(title: \"Track Your Progress\", description: \"Monitor your improvement over time with detailed analytics, rep counting, and workout history.\", image: \"chart.bar.fill\", color: .success)
    ]
    
    var body: some View {
        VStack {
            // Page Content
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(pages) { page in
                        OnboardingPageView(page: page)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .scrollPositionBehavior(. paging)
            
            // Page Indicator
            HStack {
                ForEach(0 ..< pages.count) { index in
                    Circle()
                        .fill(currentPage == index ? Color.accent : Color.border)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.vertical, 24)
            
            // Navigation
            HStack {
                if currentPage > 0 {
                    Button(action: { currentPage -= 1 }) {
                        Text(\"Back\")
                            .font(.subhead)
                            .foregroundColor(.textPrimary)
                    }
                } else {
                    Spacer()
                }
                
                if currentPage < pages.count - 1 {
                    Button(action: { currentPage += 1 }) {
                        Text(\"Next\")
                            .font(.subhead)
                            .foregroundColor(.accent)
                    }
                } else {
                    Button(action: { showMainApp = true }) {
                        Text(\"Get Started\")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(Color.accent)
                            .cornerRadius(24)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .background(Color.background.ignoresSafeArea())
        .fullScreenCover(isPresented: ) {
            ContentView()
        }
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: page.image)
                .font(.system(size: 120))
                .foregroundColor(page.color)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
