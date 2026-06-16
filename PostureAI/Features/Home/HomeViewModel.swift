import Foundation
import Combine

// MARK: - HomeViewModel

class HomeViewModel: ObservableObject {
    @Published var totalWorkouts: Int = 47
    @Published var totalMinutes: Int = 1234
    @Published var streak: Int = 12
    @Published var recentWorkouts: [WorkoutSession] = []
    @Published var exercises: [Exercise] = []
    @Published var isLoading = false
    
    private let repository: WorkoutRepository
    
    init(repository: WorkoutRepository = WorkoutRepository()) {
        self.repository = repository
    }
    
    func loadHomeData() async {
        isLoading = true
        
        // Load exercises
        exercises = [
            Exercise(id: \"1\", name: \"Squat\", description: \"Lower body strength exercise\", category: .strength, difficulty: .beginner, instructions: [\"Stand with feet shoulder-width apart\", \"Lower hips below knees\", \"Keep back straight\", \"Push through heels to stand\"], correctFormDescription: \"Keep knees behind toes and back neutral\", commonMistakes: [\"Knees collapsing inward\", \"Back rounding\", \"Heels lifting\"], caloriesPerMinute: 5.5, muscleGroups: [.legs, .glutes], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
            Exercise(id: \"2\", name: \"Push Up\", description: \"Upper body strength exercise\", category: .strength, difficulty: .intermediate, instructions: [\"Place hands shoulder-width apart\", \"Keep body in straight line\", \"Lower chest to floor\", \"Push back up\"], correctFormDescription: \"Maintain plank position throughout\", commonMistakes: [\"Hips too high\", \"Hips too low\", \"Elbows flared\"], caloriesPerMinute: 7.0, muscleGroups: [.chest, .shoulders, .triceps], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
            Exercise(id: \"3\", name: \"Bicep Curl\", description: \"Arm strength exercise\", category: .strength, difficulty: .beginner, instructions: [\"Stand with dumbbells at sides\", \"Curl weights toward shoulders\", \"Keep elbows close to body\", \"Lower slowly\"], correctFormDescription: \"Keep elbows stationary at sides\", commonMistakes: [\"Swinging body\", \"Elbows moving forward\"], caloriesPerMinute: 4.0, muscleGroups: [.biceps], requiredEquipment: [\"Dumbbells\"], estimatedDurationSeconds: 45, videoURL: nil, imageURL: nil)
        ]
        
        // Load recent workouts
        do {
            recentWorkouts = try await repository.getAll()
        } catch {
            print(\"Error loading workouts: \\(error)\")
        }
        
        isLoading = false
    }
}
