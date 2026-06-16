import Foundation
import Combine

// MARK: - WorkoutViewModel

class WorkoutViewModel: ObservableObject {
    @Published var postureScore: Double = 100
    @Published var currentRep: Int = 0
    @Published var targetReps: Int = 10
    @Published var exerciseName: String = "Squat"
    @Published var timer: TimeInterval = 0
    @Published var isRecording: Bool = false
    @Published var showWorkoutInfo: Bool = true
    @Published var showFeedback: Bool = false
    @Published var feedbackMessage: String = ""
    @Published var postureAnalysis: PostureAnalysis?
    @Published var poseLandmarks: [PoseLandmark] = []
    
    private var timerCancellable: AnyCancellable?
    private let detector = PoseDetector()
    
    func startWorkout() {
        isRecording = true
        timer = 0
        currentRep = 0
        startTimer()
        detector.startDetection()
    }
    
    func stopWorkout() {
        isRecording = false
        timerCancellable?.cancel()
        detector.stopDetection()
    }
    
    func processRep() {
        currentRep += 1
        showFeedback = true
        feedbackMessage = currentRep == targetReps ? "Perfect! Workout complete!" : "Good rep! Keep going."
    }
    
    func updatePosture(landmarks: [PoseLandmark]) {
        poseLandmarks = landmarks
        // Calculate posture score based on landmarks
        postureScore = calculatePostureScore(landmarks: landmarks)
    }
    
    private func calculatePostureScore(landmarks: [PoseLandmark]) -> Double {
        // Simple placeholder implementation
        return 85 + Double.random(in: -5...10)
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timer += 1
            }
    }
}
