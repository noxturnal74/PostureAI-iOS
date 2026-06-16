import Foundation

struct Exercise: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let description: String
    let category: ExerciseCategory
    let difficulty: DifficultyLevel
    let instructions: [String]
    let correctFormDescription: String
    let commonMistakes: [String]
    let caloriesPerMinute: Double
    let muscleGroups: [MuscleGroup]
    let requiredEquipment: [String]
    let estimatedDurationSeconds: Int
    let videoURL: String?
    let imageURL: String?
    
    enum ExerciseCategory: String, Codable {
        case strength = \"Strength\"
        case cardio = \"Cardio\"
        case flexibility = \"Flexibility\"
        case core = \"Core\"
        case balance = \"Balance\"
    }
    
    enum DifficultyLevel: String, Codable {
        case beginner = \"Beginner\"
        case intermediate = \"Intermediate\"
        case advanced = \"Advanced\"
    }
    
    enum MuscleGroup: String, Codable {
        case chest = \"Chest\"
        case back = \"Back\"
        case shoulders = \"Shoulders\"
        case biceps = \"Biceps\"
        case triceps = \"Triceps\"
        case legs = \"Legs\"
        case glutes = \"Glutes\"
        case abs = \"Abs\"
        case obliques = \"Obliques\"
        case fullBody = \"Full Body\"
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
}
