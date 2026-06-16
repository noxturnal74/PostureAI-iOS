import Foundation
import Combine

// MARK: - AICoachViewModel

class AICoachViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isTyping = false
    @Published var currentExercise: String = \"Squat\"
    
    private var detector: PoseDetector
    
    init(detector: PoseDetector = PoseDetector()) {
        self.detector = detector
        self.messages = [
            ChatMessage(id: \"1\", text: \"Hello! I'm your AI fitness coach. I can help you with proper form, rep counting, and technique improvements. What exercise are we doing today?\", isUser: false, timestamp: Date())
        ]
    }
    
    func sendMessage(_ text: String) async {
        isTyping = true
        
        // Simulate AI response based on context
        let response = await generateAIResponse(text)
        
        messages.append(ChatMessage(id: UUID().uuidString, text: text, isUser: true, timestamp: Date()))
        messages.append(ChatMessage(id: UUID().uuidString, text: response, isUser: false, timestamp: Date()))
        
        isTyping = false
    }
    
    private func generateAIResponse(_ text: String) async -> String {
        let lowerText = text.lowercased()
        
        if lowerText.contains(\"squat\") {
            return \"Great choice! Remember to keep your feet shoulder-width apart, chest up, and knees behind your toes. I'll analyze your form in real-time and give you instant feedback.\"
        } else if lowerText.contains(\"push\") || lowerText.contains(\"pushup\") {
            return \"Perfect! For push-ups, make sure your hands are shoulder-width apart, your body forms a straight line from head to heels, and you lower your chest to about 90 degrees. Let's get started!\"
        } else if lowerText.contains(\"plank\") {
            return \"Excellent for core strength! Keep your body in a straight line, engage your core, and don't let your hips sag. Ready to track your plank time?\"
        } else {
            return \"I can help you with Squat, Push Up, Bicep Curl, Dumbbell Fly, Dumbbell Kickback, or Plank. Which exercise would you like to do? I'll analyze your form and count reps automatically.\"
        }
    }
    
    func updateWorkoutStatus(_ status: WorkoutStatus) {
        // Update workout status in AI coach
    }
    
    enum WorkoutStatus {
        case start, repComplete, formFeedback, workoutComplete
    }
}

struct ChatMessage: Identifiable, Equatable {
    let id: String
    let text: String
    let isUser: Bool
    let timestamp: Date
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }
}
