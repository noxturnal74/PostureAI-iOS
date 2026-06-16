import SwiftUI

struct WorkoutCameraView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            CameraPreview(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.showWorkoutInfo {
                WorkoutInfoOverlay(viewModel: viewModel)
            }
            
            TopHUD(viewModel: viewModel)
            
            BottomControls(viewModel: viewModel)
            
            if viewModel.showFeedback {
                FeedbackOverlay(viewModel: viewModel)
            }
        }
    }
}

class WorkoutViewModel: ObservableObject {
    @Published var postureScore: Double = 100
    @Published var currentRep: Int = 0
    @Published var targetReps: Int = 10
    @Published var exerciseName: String = \"Squat\"
    @Published var timer: TimeInterval = 0
    @Published var isRecording: Bool = false
    @Published var showWorkoutInfo: Bool = true
    @Published var showFeedback: Bool = false
    @Published var feedbackMessage: String = \"\"
    @Published var postureAnalysis: PostureAnalysis?
    
    func startWorkout() {
        isRecording = true
        timer = 0
        currentRep = 0
    }
    
    func stopWorkout() {
        isRecording = false
    }
    
    func processRep() {
        currentRep += 1
        showFeedback = true
        feedbackMessage = currentRep == targetReps ? \"Perfect! Workout complete!\" : \"Good rep! Keep going.\"
    }
}

struct CameraPreview: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack {
            if viewModel.isRecording {
                CameraFeed()
            } else {
                StartScreen(viewModel: viewModel)
            }
        }
    }
}

struct CameraFeed: View {
    var body: some View {
        Color.black
            .overlay(
                Text(\"Camera Active\")
                    .foregroundColor(.white)
            )
    }
}

struct StartScreen: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: \"figure.strength??\")
                .font(.system(size: 80))
                .foregroundColor(.accent)
            
            Text(viewModel.exerciseName)
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            Button(action: { viewModel.startWorkout() }) {
                Image(systemName: \"play.fill\")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(24)
                    .background(Color.accent)
                    .cornerRadius(48)
                    .shadow(color: Color.accent.opacity(0.3), radius: 16)
            }
            
            Text(\"Tap to begin workout\")
                .font(.subhead)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

struct TopHUD: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(\"\\(formatTime(viewModel.timer))\")
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4)
                Text(viewModel.exerciseName)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(\"\\(viewModel.currentRep)/\\(viewModel.targetReps)\")
                    .font(.system(.title, design: .monospaced))
                    .bold()
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4)
                Text(\"Reps\")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 48)
    }
    
    func formatTime(_ seconds: TimeInterval) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return \"\\(mins):\\(String(format: \"%02d\", secs))\"
    }
}

struct BottomControls: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 24) {
                Button(action: { viewModel.stopWorkout() }) {
                    Image(systemName: \"stop.fill\")
                        .font(.title2)
                        .foregroundColor(.error)
                        .padding(16)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(48)
                }
                Button(action: { viewModel.processRep() }) {
                    Image(systemName: \"hand.thumbsup.fill\")
                        .font(.title2)
                        .foregroundColor(.success)
                        .padding(16)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(48)
                }
            }
            .padding(.bottom, 48)
        }
    }
}

struct WorkoutInfoOverlay: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        Color.black.opacity(0.7)
            .ignoresSafeArea()
            .onTapGesture { viewModel.showWorkoutInfo = false }
            .overlay(
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: \"info.circle.fill\")
                            .foregroundColor(.accent)
                        Text(\"Workout Tips\")
                            .font(.headline)
                    }
                    Text(\"Keep your back straight and core engaged throughout the exercise.\")
                        .font(.body)
                        .foregroundColor(.white)
                    Button(\"Got it\") {
                        viewModel.showWorkoutInfo = false
                    }
                    .buttonStyle(PrimaryButtonConfiguration())
                }
                .padding(24)
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
                .padding(24)
            )
    }
}

struct FeedbackOverlay: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        Color.black.opacity(0.7)
            .ignoresSafeArea()
            .onTapGesture { viewModel.showFeedback = false }
            .overlay(
                VStack(spacing: 16) {
                    Image(systemName: viewModel.currentRep == viewModel.targetReps ? \"checkmark.circle.fill\" : \"sparkles\")
                        .font(.system(size: 64))
                        .foregroundColor(.accent)
                    Text(viewModel.feedbackMessage)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    Button(\"Continue\") {
                        viewModel.showFeedback = false
                    }
                    .buttonStyle(PrimaryButtonConfiguration())
                }
                .padding(32)
                .background(Color.black)
                .cornerRadius(24)
                .padding(32)
            )
    }
}

struct WorkoutCameraView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCameraView()
    }
}
