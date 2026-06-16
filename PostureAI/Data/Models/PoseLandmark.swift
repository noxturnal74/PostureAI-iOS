import Foundation

struct PoseLandmark: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let x: Double
    let y: Double
    let z: Double?
    let visibility: Double
    
    static func == (lhs: PoseLandmark, rhs: PoseLandmark) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - 33 MediaPipe Pose Landmarks

extension PoseLandmark {
    static let all: [PoseLandmark] = [
        PoseLandmark(id: 0, name: "nose", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 1, name: "leftEyeInner", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 2, name: "leftEye", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 3, name: "leftEyeOuter", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 4, name: "rightEyeInner", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 5, name: "rightEye", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 6, name: "rightEyeOuter", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 7, name: "leftEar", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 8, name: "rightEar", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 9, name: "mouthLeft", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 10, name: "mouthRight", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 11, name: "leftShoulder", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 12, name: "rightShoulder", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 13, name: "leftElbow", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 14, name: "rightElbow", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 15, name: "leftWrist", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 16, name: "rightWrist", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 17, name: "leftPinky", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 18, name: "rightPinky", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 19, name: "leftIndex", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 20, name: "rightIndex", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 21, name: "leftThumb", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 22, name: "rightThumb", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 23, name: "leftHip", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 24, name: "rightHip", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 25, name: "leftKnee", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 26, name: "rightKnee", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 27, name: "leftAnkle", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 28, name: "rightAnkle", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 29, name: "leftHeel", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 30, name: "rightHeel", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 31, name: "leftFootIndex", x: 0, y: 0, z: 0, visibility: 0),
        PoseLandmark(id: 32, name: "rightFootIndex", x: 0, y: 0, z: 0, visibility: 0)
    ]
}
