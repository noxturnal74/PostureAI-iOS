import SwiftUI

// MARK: - PostureErrorDetector

struct PostureErrorDetector {
    static func detectErrors(landmarks: [PoseLandmark], exerciseType: ExerciseType) -> [PostureAnalysis.PostureError] {
        var errors: [PostureAnalysis.PostureError] = []
        
        switch exerciseType {
        case .squat:
            errors.append(contentsOf: detectSquatErrors(landmarks: landmarks))
        case .pushUp:
            errors.append(contentsOf: detectPushUpErrors(landmarks: landmarks))
        case .plank:
            errors.append(contentsOf: detectPlankErrors(landmarks: landmarks))
        case .bicepCurl:
            errors.append(contentsOf: detectBicepCurlErrors(landmarks: landmarks))
        default:
            break
        }
        
        return errors
    }
    
    // MARK: - Squat Error Detection
    
    private static func detectSquatErrors(landmarks: [PoseLandmark]) -> [PostureAnalysis.PostureError] {
        var errors: [PostureAnalysis.PostureError] = []
        
        guard let leftHip = landmarks.first(where: { .id == 23 }),
              let leftKnee = landmarks.first(where: { .id == 25 }),
              let leftAnkle = landmarks.first(where: { .id == 27 }) else {
            return errors
        }
        
        // Calculate knee angle
        let kneeAngle = calculateAngle(leftHip, leftKnee, leftAnkle)
        
        // Check if knees too far forward
        if kneeAngle > 120 {
            errors.append(.kneesTooFarForward)
        }
        
        // Check for knee collapsing (valgus)
        if let rightKnee = landmarks.first(where: { .id == 26 }) {
            let kneeDistance = abs(leftKnee.x - rightKnee.x)
            if kneeDistance < 0.1 {
                errors.append(.kneesCollapsing)
            }
        }
        
        return errors
    }
    
    // MARK: - Push Up Error Detection
    
    private static func detectPushUpErrors(landmarks: [PoseLandmark]) -> [PostureAnalysis.PostureError] {
        var errors: [PostureAnalysis.PostureError] = []
        
        guard let leftShoulder = landmarks.first(where: { .id == 11 }),
              let leftElbow = landmarks.first(where: { .id == 13 }),
              let leftWrist = landmarks.first(where: { .id == 15 }),
              let leftHip = landmarks.first(where: { .id == 23 }) else {
            return errors
        }
        
        // Calculate elbow angle
        let elbowAngle = calculateAngle(leftShoulder, leftElbow, leftWrist)
        
        // Check if hips too high (?? up)
        let hipShoulderAngle = calculateAngle(leftShoulder, leftHip, leftElbow)
        if hipShoulderAngle > 140 {
            errors.append(.hipsTooHigh)
        }
        
        // Check if hips too low
        if hipShoulderAngle < 100 {
            errors.append(.hipsTooLow)
        }
        
        return errors
    }
    
    // MARK: - Plank Error Detection
    
    private static func detectPlankErrors(landmarks: [PoseLandmark]) -> [PostureAnalysis.PostureError] {
        var errors: [PostureAnalysis.PostureError] = []
        
        guard let leftShoulder = landmarks.first(where: { .id == 11 }),
              let leftHip = landmarks.first(where: { .id == 23 }),
              let leftAnkle = landmarks.first(where: { .id == 27 }) else {
            return errors
        }
        
        // Calculate body angle from horizontal
        let bodyAngle = calculateAngle(leftShoulder, leftHip, leftAnkle)
        
        // Check for sagging hips
        if bodyAngle < 170 {
            errors.append(.hipsTooLow)
        }
        
        // Check for raised hips
        if bodyAngle > 175 {
            errors.append(.hipsTooHigh)
        }
        
        return errors
    }
    
    // MARK: - Bicep Curl Error Detection
    
    private static func detectBicepCurlErrors(landmarks: [PoseLandmark]) -> [PostureAnalysis.PostureError] {
        var errors: [PostureAnalysis.PostureError] = []
        
        guard let leftShoulder = landmarks.first(where: { .id == 11 }),
              let leftElbow = landmarks.first(where: { .id == 13 }),
              let leftWrist = landmarks.first(where: { .id == 15 }) else {
            return errors
        }
        
        let elbowAngle = calculateAngle(leftShoulder, leftElbow, leftWrist)
        
        // Check if using momentum (swinging)
        if elbowAngle > 150 {
            errors.append(.timingIssue)
        }
        
        return errors
    }
    
    // MARK: - Helper Functions
    
    private static func calculateAngle(_ p1: PoseLandmark, _ p2: PoseLandmark, _ p3: PoseLandmark) -> Double {
        let dx1 = p1.x - p2.x
        let dy1 = p1.y - p2.y
        let dx2 = p3.x - p2.x
        let dy2 = p3.y - p2.y
        
        let dot = dx1 * dx2 + dy1 * dy2
        let mag1 = sqrt(dx1 * dx1 + dy1 * dy1)
        let mag2 = sqrt(dx2 * dx2 + dy2 * dy2)
        
        guard mag1 > 0, mag2 > 0 else { return 0 }
        
        let angle = acos(dot / (mag1 * mag2))
        return angle * 180 / .pi
    }
}

enum ExerciseType {
    case squat
    case pushUp
    case plank
    case bicepCurl
}
