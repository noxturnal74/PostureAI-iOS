import SwiftUI

// MARK: - PoseDetector

enum PoseDetectionError: Error {
    case noPoseDetected
    case insufficientConfidence
    case cameraNotAvailable
    case modelNotFound
}

struct PoseDetectionResult {
    let landmarks: [PoseLandmark]
    let confidence: Double
    let timestamp: Date
    let frameIndex: Int
}

protocol PoseDetectorProtocol {
    func startDetection() async throws
    func stopDetection()
    func detectPose(from image: CGImage) async throws -> PoseDetectionResult
    func calculateAngle(from: PoseLandmark, to: PoseLandmark, to: PoseLandmark) -> Double
}

final class PoseDetector: PoseDetectorProtocol {
    private var isRunning: Bool = false
    private let minimumConfidence: Double = 0.5
    
    func startDetection() async throws {
        guard !isRunning else { return }
        isRunning = true
    }
    
    func stopDetection() {
        isRunning = false
    }
    
    func detectPose(from image: CGImage) async throws -> PoseDetectionResult {
        guard isRunning else {
            throw PoseDetectionError.noPoseDetected
        }
        
        // MediaPipe Pose Landmarker integration would go here
        // This is a placeholder implementation
        
        throw NSError(domain: \"PoseDetector\", code: 0, userInfo: [NSLocalizedDescriptionKey: \"MediaPipe integration not yet implemented\"])
    }
    
    func calculateAngle(from startPoint: PoseLandmark, to vertexPoint: PoseLandmark, to endPoint: PoseLandmark) -> Double {
        let dx1 = startPoint.x - vertexPoint.x
        let dy1 = startPoint.y - vertexPoint.y
        let dx2 = endPoint.x - vertexPoint.x
        let dy2 = endPoint.y - vertexPoint.y
        
        let dot = dx1 * dx2 + dy1 * dy2
        let mag1 = sqrt(dx1 * dx1 + dy1 * dy1)
        let mag2 = sqrt(dx2 * dx2 + dy2 * dy2)
        
        guard mag1 > 0, mag2 > 0 else { return 0 }
        
        let angle = acos(dot / (mag1 * mag2))
        return angle * 180 / .pi
    }
    
    func calculateAngle3D(from startPoint: PoseLandmark, to vertexPoint: PoseLandmark, to endPoint: PoseLandmark) -> Double {
        let dx1 = startPoint.x - vertexPoint.x
        let dy1 = startPoint.y - vertexPoint.y
        let dz1 = (startPoint.z ?? 0) - (vertexPoint.z ?? 0)
        let dx2 = endPoint.x - vertexPoint.x
        let dy2 = endPoint.y - vertexPoint.y
        let dz2 = (endPoint.z ?? 0) - (vertexPoint.z ?? 0)
        
        let dot = dx1 * dx2 + dy1 * dy2 + dz1 * dz2
        let mag1 = sqrt(dx1 * dx1 + dy1 * dy1 + dz1 * dz1)
        let mag2 = sqrt(dx2 * dx2 + dy2 * dy2 + dz2 * dz2)
        
        guard mag1 > 0, mag2 > 0 else { return 0 }
        
        let angle = acos(dot / (mag1 * mag2))
        return angle * 180 / .pi
    }
}

// MARK: - RepetitionCounter

class RepetitionCounter {
    private var currentRepState: RepState = .up
    private var repCount: Int = 0
    private var thresholds: (down: Double, up: Double) = (60, 120)
    
    enum RepState {
        case up, down, movingDown, movingUp
    }
    
    func countRep(currentAngle: Double) -> (count: Int, state: RepState) {
        switch currentRepState {
        case .up:
            if currentAngle < thresholds.down {
                currentRepState = .movingDown
            }
        case .down:
            if currentAngle > thresholds.up {
                currentRepState = .movingUp
                repCount += 1
            }
        case .movingDown:
            if currentAngle >= thresholds.down {
                currentRepState = .down
            }
        case .movingUp:
            if currentAngle <= thresholds.up {
                currentRepState = .up
            }
        }
        
        return (repCount, currentRepState)
    }
    
    func reset() {
        repCount = 0
        currentRepState = .up
    }
    
    func getRepCount() -> Int {
        repCount
    }
}
