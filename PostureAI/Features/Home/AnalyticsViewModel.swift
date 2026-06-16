import Foundation
import Combine

// MARK: - AnalyticsViewModel

class AnalyticsViewModel: ObservableObject {
    @Published var totalWorkouts: Int = 0
    @Published var totalMinutes: Int = 0
    @Published var totalReps: Int = 0
    @Published var averagePostureScore: Double = 0
    @Published var currentStreak: Int = 0
    @Published var workouts: [WorkoutSession] = []
    @Published var selectedTimeframe: Timeframe = .week
    
    enum Timeframe {
        case day, week, month, year
    }
    
    private let repository: WorkoutRepository
    
    init(repository: WorkoutRepository = WorkoutRepository()) {
        self.repository = repository
    }
    
    func loadAnalytics() async {
        do {
            workouts = try await repository.getAll()
            calculateStats()
        } catch {
            print(\"Error loading analytics: \\(error)\")
        }
    }
    
    private func calculateStats() {
        totalWorkouts = workouts.count
        totalMinutes = workouts.reduce(0) {  + (.durationSeconds ?? 0) / 60 }
        totalReps = workouts.reduce(0) {  + .totalReps }
        
        let scores = workouts.flatMap { .postureAnalysis }.map { .score }
        averagePostureScore = scores.isEmpty ? 0 : scores.reduce(0, +) / Double(scores.count)
        
        calculateStreak()
    }
    
    private func calculateStreak() {
        let today = Date()
        var consecutiveDays = 0
        
        for i in 0..<30 {
            let dayDate = Calendar.current.date(byAdding: .day, value: -i, to: today)!
            if workouts.contains(where: { Calendar.current.isDate(.startTime, inSameDayAs: dayDate) }) {
                consecutiveDays += 1
            } else if i > 0 {
                break
            }
        }
        
        currentStreak = consecutiveDays
    }
}
