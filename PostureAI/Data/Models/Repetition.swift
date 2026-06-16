import Foundation

struct Repetition: Identifiable, Codable {
    let id: String
    let workoutSessionId: String
    let repNumber: Int
    let startTime: Date
    let endTime: Date
    let durationSeconds: Double
    let peakPosition: RepetitionPeakPosition
    let startPose: [PoseLandmark]
    let endPose: [PoseLandmark]
    let qualityScore: Double
    let errors: [RepError]
    
    enum RepetitionPeakPosition: String, Codable {
        case bottom = \"bottom\"
        case top = \"top\"
        case mid = \"mid\"
    }
    
    enum RepError: String, Codable, CaseIterable {
        case incorrectRange = \"Incorrect Range\"
        case poorForm = \"Poor Form\"
        case timingIssue = \"Timing Issue\"
        case balanceIssue = \"Balance Issue\"
        case other = \"Other\"
        
        var description: String {
            switch self {
            case .incorrectRange: return \"Didn't go through full range of motion\"
            case .poorForm: return \"Form was off - check your technique\"
            case .timingIssue: return \"Rep was too fast or too slow\"
            case .balanceIssue: return \"Lost balance during movement\"
            case .other: return \"Minor form issue detected\"
            }
        }
    }
    
    var hasError: Bool {
        !errors.isEmpty
    }
}
