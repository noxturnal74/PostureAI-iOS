import SwiftUI
import UniformTypeIdentifiers

struct AnalyticsView: View {
    @StateObject private var viewModel = AnalyticsViewModel()
    
    let days = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]
    let repsData = [120, 95, 150, 110, 180, 140, 100]
    let scoresData = [85, 82, 88, 84, 90, 86, 83]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(\"Your Progress\")
                        .font(.title)
                        .bold()
                    Text(\"Keep up the great work!\")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                // Main Stats
                HStack(spacing: 12) {
                    StatBox(title: \"Total Reps\", value: \"\\(viewModel.totalReps)\", icon: \"repeat.circle.fill\", color: .accent)
                    StatBox(title: \"Avg Score\", value: \"\\(Int(viewModel.averagePostureScore))%\", icon: \"checkmark.seal.fill\", color: .success)
                    StatBox(title: \"Workouts\", value: \"\\(viewModel.totalWorkouts)\", icon: \"dumbbell.fill\", color: .warning)
                }
                .padding(.horizontal, 16)
                
                // Progress Chart
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(\"Reps Per Workout\")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    ChartView(data: repsData)
                }
                .padding(.horizontal, 16)
                
                // Exercise Breakdown
                VStack(alignment: .leading, spacing: 16) {
                    Text(\"By Exercise\")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ExerciseProgressRow(name: \"Squat\", percentage: 35, color: .accent)
                    ExerciseProgressRow(name: \"Push Up\", percentage: 30, color: .warning)
                    ExerciseProgressRow(name: \"Bicep Curl\", percentage: 15, color: .info)
                    ExerciseProgressRow(name: \"Plank\", percentage: 20, color: .success)
                }
                .padding(.horizontal, 16)
                
                // Weekly Streak
                VStack(alignment: .leading, spacing: 16) {
                    Text(\"Current Streak\")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    HStack {
                        ForEach(0 ..< 7) { day in
                            let isCompleted = day < 5
                            Circle()
                                .fill(isCompleted ? Color.accent : Color.border)
                                .frame(width: 16, height: 16)
                            if day < 6 {
                                Spacer(minLength: 4)
                            }
                        }
                    }
                    HStack {
                        Text(\"\\(viewModel.currentStreak) days\")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal, 16)
                        Text(\"current streak\")
                            .font(.subhead)
                            .foregroundColor(.textMuted)
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .background(Color.secondaryBackground.ignoresSafeArea())
        .navigationTitle(\"Analytics\")
        .onAppear {
            Task { await viewModel.loadAnalytics() }
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(value)
                .font(.title3)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.textMuted)
                .multilineTextAlignment(.center)
        }
        .card()
        .frame(width: (UIScreen.main.bounds.width - 56) / 3)
    }
}

struct ChartView: View {
    let data: [Int]
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(spacing: 8) {
                ForEach(Array(data.enumerated()), id: 0) { index, value in
                    BarView(value: Double(value), maxValue: 200, color: .accent)
                    Text(\"\\(days[index])\")
                        .font(.caption)
                        .foregroundColor(.textMuted)
                        .frame(width: 24)
                }
            }
        }
    }
    
    let days = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]
}

struct BarView: View {
    let value: Double
    let maxValue: Double
    let color: Color
    
    var body: some View {
        VStack {
            Spacer()
            Capsule()
                .fill(color)
                .frame(width: 16, height: (value / maxValue) * 100)
                .animation(.spring(), value: value)
        }
        .frame(height: 120)
    }
}

struct ExerciseProgressRow: View {
    let name: String
    let percentage: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(name)
                    .font(.subhead)
                Spacer()
                Text(\"\\(percentage)%\")
                    .font(.subhead)
                    .bold()
            }
            GeometryReader { geo in
                Capsule()
                    .fill(Color.border)
                    .frame(height: 8)
                Capsule()
                    .fill(color)
                    .frame(width: geo.size.width * CGFloat(percentage) / 100, height: 8)
            }
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
