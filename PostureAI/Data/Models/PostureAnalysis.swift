import Foundation
import Combine

struct PostureAnalysis: Identifiable, Codable {
    let id: String
    let workoutSessionId: String
    let timestamp: Date
    let frameIndex: Int
    let poseLandmarks: [PoseLandmark]
    let detectedAngle: Double?
    let targetAngle: Double?
    let angleDiff: Double?
    let score: Double
    let isCorrect: Bool
    let postureState: PostureState
    let errors: [PostureError]
    
    enum PostureState: String, Codable {
        case starting = \"starting\"
        case working = \"working\"
        case resting = \"resting\"
        case completed = \"completed\"
        case invalid = \"invalid\"
    }
    
    enum PostureError: String, Codable, CaseIterable {
        case backTooFlat = \"Back too flat\"
        case backTooArched = \"Back too arched\"
        case kneesTooFarForward = \"Knees too far forward\"
        case kneesCollapsing = \"Knees collapsing inward\"
        case backRounding = \"Back rounding\"
        case shoulderDysfunction = \"Shoulder dysfunction\"
        case headTooForward = \"Head too forward\"
        case hipsTooHigh = \"Hips too high\"
        case hipsTooLow = \"Hips too low\"
        case spineNotNeutral = \"Spine not neutral\"
        case other = \"Other\"
        
        var description: String {
            switch self {
            case .backTooFlat: return \"Your back is too flat - maintain natural curve\"
            case .backTooArched: return \"Avoid excessive arching - keep core engaged\"
            case .kneesTooFarForward: return \"Keep knees behind toes\"
            case .kneesCollapsing: return \"Push knees outward\"
            case .backRounding: return \"Keep back straight - don't round\"
            case .shoulderDysfunction: return \"Shoulders should be relaxed\"
            case .headTooForward: return \"Keep head neutral, not jutting forward\"
            case .hipsTooHigh: return \"Lower hips slightly\"
            case .hipsTooLow: return \"Raise hips slightly\"
            case .spineNotNeutral: return \"Maintain neutral spine position\"
            case .other: return \"Posture correction needed\"
            }
        }
    }
    
    var hasError: Bool {
        !errors.isEmpty
    }
    
    var qualityLabel: String {
        switch score {
        case 0.9...1.0: return "Excellent"
        case 0.7...0.9: return "Good"
        case 0.5...0.7: return "Fair"
        default: return "Needs Improvement"
        }
    }
}
