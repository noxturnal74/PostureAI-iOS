import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showWorkoutSheet = false
    
    let exercises: [Exercise] = [
        Exercise(id: \"1\", name: \"Squat\", description: \"Lower body strength exercise\", category: .strength, difficulty: .beginner, instructions: [\"Stand with feet shoulder-width apart\", \"Lower hips below knees\", \"Keep back straight\", \"Push through heels to stand\"], correctFormDescription: \"Keep knees behind toes and back neutral\", commonMistakes: [\"Knees collapsing inward\", \"Back rounding\", \"Heels lifting\"], caloriesPerMinute: 5.5, muscleGroups: [.legs, .glutes], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
        Exercise(id: \"2\", name: \"Push Up\", description: \"Upper body strength exercise\", category: .strength, difficulty: .intermediate, instructions: [\"Place hands shoulder-width apart\", \"Keep body in straight line\", \"Lower chest to floor\", \"Push back up\"], correctFormDescription: \"Maintain plank position throughout\", commonMistakes: [\"Hips too high\", \"Hips too low\", \"Elbows flared\"], caloriesPerMinute: 7.0, muscleGroups: [.chest, .shoulders, .triceps], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
        Exercise(id: \"3\", name: \"Bicep Curl\", description: \"Arm strength exercise\", category: .strength, difficulty: .beginner, instructions: [\"Stand with dumbbells at sides\", \"Curl weights toward shoulders\", \"Keep elbows close to body\", \"Lower slowly\"], correctFormDescription: \"Keep elbows stationary at sides\", commonMistakes: [\"Swinging body\", \"Elbows moving forward\"], caloriesPerMinute: 4.0, muscleGroups: [.biceps], requiredEquipment: [\"Dumbbells\"], estimatedDurationSeconds: 45, videoURL: nil, imageURL: nil)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(\"Good \", dynamicTextSizing: true)
                        .font(.subhead)
                        .foregroundColor(.textMuted)
                    if Calendar.current.isDateInToday(Date()) {
                        Text(\"Let's get moving!\", dynamicTextSizing: true)
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                    } else {
                        Text(\"Ready to train?\", dynamicTextSizing: true)
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                    }
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: \"person.circle.fill\")
                        .font(.title2)
                        .foregroundColor(.accent)
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.top, Spacing.lg)
            
            // Stats Cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    StatCard(title: \"Total Workouts\", value: \"47\", icon: \"dumbbell.fill\", color: .accent)
                    StatCard(title: \"Minutes Trained\", value: \"1,234\", icon: \"clock.fill\", color: .warning)
                    StatCard(title: \"Streak\", value: \"12\", icon: \"flame.fill\", color: .error)
                }
                .padding(.horizontal, Spacing.md)
            }
            
            // Recent Workouts
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Text(\"Recent Workouts\")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    Spacer()
                    Button(action: {}) {
                        Text(\"See All\")
                            .font(.subhead)
                            .foregroundColor(.accent)
                    }
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, Spacing.xs)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.md) {
                        WorkoutCard(workout: WorkoutSession(
                            id: \"1\",
                            userId: \"user1\",
                            exerciseId: \"1\",
                            exerciseName: \"Squat\",
                            startTime: Date().addingTimeInterval(-3600),
                            endTime: nil,
                            durationSeconds: nil,
                            totalReps: 0,
                            completedReps: [],
                            postureAnalysis: [],
                            caloriesBurned: 0,
                            rating: nil,
                            notes: nil,
                            status: .inProgress,
                            createdAt: Date()
                        ))
                        WorkoutCard(workout: WorkoutSession(
                            id: \"2\",
                            userId: \"user1\",
                            exerciseId: \"2\",
                            exerciseName: \"Push Up\",
                            startTime: Date().addingTimeInterval(-7200),
                            endTime: Date().addingTimeInterval(-6600),
                            durationSeconds: 1100,
                            totalReps: 50,
                            completedReps: [],
                            postureAnalysis: [],
                            caloriesBurned: 77,
                            rating: 5,
                            notes: nil,
                            status: .completed,
                            createdAt: Date()
                        ))
                    }
                    .padding(.horizontal, Spacing.md)
                }
            }
            
            // Quick Start Section
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Text(\"Quick Start\")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, Spacing.xs)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.md) {
                        ForEach(exercises) { exercise in
                            ExerciseCard(exercise: exercise) { _ in
                                showWorkoutSheet = true
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.md)
                }
            }
            
            Spacer()
        }
        .background(Color.secondaryBackground)
        .sheet(isPresented: ) {
            WorkoutView(exerciseId: exercises.first?.id ?? \"\")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(value)
                .font(.title3)
                .bold()
                .foregroundColor(.textPrimary)
            Text(title)
                .font(.caption)
                .foregroundColor(.textMuted)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
        .card()
    }
}

struct WorkoutCard: View {
    let workout: WorkoutSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack {
                Image(systemName: \"checkmark.circle.fill\")
                    .foregroundColor(.success)
                Text(workout.exerciseName)
                    .font(.subhead)
                    .bold()
                    .foregroundColor(.textPrimary)
                Spacer()
                Text(workout.status == .completed ? \"Completed\" : \"In Progress\")
                    .font(.caption)
                    .foregroundColor(workout.status == .completed ? .success : .accent)
            }
            HStack(spacing: 16) {
                if let duration = workout.durationSeconds {
                    Text(\"\\(formatDuration(seconds: duration))\")
                        .font(.caption)
                        .foregroundColor(.textMuted)
                }
                if workout.status == .completed {
                    Text(\"\\(workout.totalReps) reps\")
                        .font(.caption)
                        .foregroundColor(.textMuted)
                    Text(\"\\(Int(workout.caloriesBurned)) cal\")
                        .font(.caption)
                        .foregroundColor(.textMuted)
                }
            }
        }
        .padding(Spacing.md)
        .card()
        .frame(width: 160)
    }
    
    func formatDuration(seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return \"\\(minutes):\\(String(format: \"%02d\", secs))\"
    }
}

struct ExerciseCard: View {
    let exercise: Exercise
    let onSelect: (Exercise) -> Void
    
    var body: some View {
        Button(action: { onSelect(exercise) }) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack {
                    Image(systemName: \"figure.strength??\")
                        .font(.title2)
                        .foregroundColor(.accent)
                    Spacer()
                    Text(exercise.difficulty.rawValue)
                        .font(.caption)
                        .padding(.horizontal, Spacing.xxs)
                        .background(Color.border)
                        .cornerRadius(CornerRadius.xxs)
                }
                Text(exercise.name)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                Text(exercise.description)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
            }
            .padding(Spacing.md)
            .card()
            .frame(width: 140)
        }
    }
}

struct WorkoutView: View {
    let exerciseId: String
    
    var body: some View {
        VStack {
            Text(\"Workout View\")
                .font(.title)
            Text(\"Exercise ID: \\(exerciseId)\")
                .font(.subhead)
                .foregroundColor(.textMuted)
            
            Button(\"Start Camera Workout\") {
                // Start workout
            }
            .buttonStyle(PrimaryButtonConfiguration())
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .background(Color.secondaryBackground)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
