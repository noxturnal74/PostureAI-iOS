import Foundation
import Combine

struct WorkoutSession: Identifiable, Codable {
    let id: String
    let userId: String
    let exerciseId: String
    let exerciseName: String
    let startTime: Date
    let endTime: Date?
    let durationSeconds: Int?
    let totalReps: Int
    let completedReps: [Repetition]
    let postureAnalysis: [PostureAnalysis]
    let caloriesBurned: Double
    let rating: Int?
    let notes: String?
    let status: SessionStatus
    let createdAt: Date
    
    enum SessionStatus: String, Codable {
        case pending = \"pending\"
        case inProgress = \"in_progress\"
        case completed = \"completed\"
        case cancelled = \"cancelled\"
    }
    
    var averagePostureScore: Double {
        postureAnalysis.isEmpty ? 0 : postureAnalysis.reduce(0) {  + .score } / Double(postureAnalysis.count)
    }
    
    var hasError: Bool {
        postureAnalysis.contains { .hasError }
    }
}
