import SwiftUI

struct HistoryView: View {
    @State private var workouts = [
        WorkoutSession(
            id: \"1\",
            userId: \"user1\",
            exerciseId: \"1\",
            exerciseName: \"Squat\",
            startTime: Date().addingTimeInterval(-86400),
            endTime: Date().addingTimeInterval(-86100),
            durationSeconds: 300,
            totalReps: 30,
            completedReps: [],
            postureAnalysis: [],
            caloriesBurned: 45,
            rating: 4,
            notes: \"Good session\",
            status: .completed,
            createdAt: Date()
        ),
        WorkoutSession(
            id: \"2\",
            userId: \"user1\",
            exerciseId: \"2\",
            exerciseName: \"Push Up\",
            startTime: Date().addingTimeInterval(-172800),
            endTime: Date().addingTimeInterval(-172200),
            durationSeconds: 600,
            totalReps: 50,
            completedReps: [],
            postureAnalysis: [],
            caloriesBurned: 70,
            rating: 5,
            notes: nil,
            status: .completed,
            createdAt: Date()
        ),
        WorkoutSession(
            id: \"3\",
            userId: \"user1\",
            exerciseId: \"1\",
            exerciseName: \"Squat\",
            startTime: Date().addingTimeInterval(-259200),
            endTime: Date().addingTimeInterval(-258900),
            durationSeconds: 300,
            totalReps: 25,
            completedReps: [],
            postureAnalysis: [],
            caloriesBurned: 38,
            rating: 3,
            notes: nil,
            status: .completed,
            createdAt: Date()
        )
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(\"This Week\").font(.subhead).foregroundColor(.textMuted)) {
                    ForEach(workouts.filter { Calendar.current.isDateInToday(.startTime) || Calendar.current.isDate(.startTime, inSameDayAs: Date().addingTimeInterval(-86400)) }) { workout in
                        WorkoutHistoryRow(workout: workout)
                    }
                }
                
                Section(header: Text(\"Previous Week\").font(.subhead).foregroundColor(.textMuted)) {
                    ForEach(workouts.filter { !Calendar.current.isDateInToday(.startTime) && !Calendar.current.isDate(.startTime, inSameDayAs: Date().addingTimeInterval(-86400)) }) { workout in
                        WorkoutHistoryRow(workout: workout)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.secondaryBackground)
            .navigationTitle(\"History\")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: \"slider.horizontal.3\")
                    }
                }
            }
        }
    }
}

struct WorkoutHistoryRow: View {
    let workout: WorkoutSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: \"figure.strength??\")
                    .foregroundColor(.accent)
                Text(workout.exerciseName)
                    .font(.headline)
                Spacer()
                Text(formatDate(workout.startTime))
                    .font(.caption)
                    .foregroundColor(.textMuted)
            }
            HStack {
                Text(\"\\(workout.totalReps) reps\")
                    .font(.subhead)
                    .foregroundColor(.textSecondary)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: \"star.fill\")
                        .foregroundColor(.accent)
                    Text(\"\\(workout.rating ?? 0)\")
                        .font(.subhead)
                }
            }
            HStack {
                Text(\"\\(Int(workout.caloriesBurned)) cal burned\")
                    .font(.caption)
                    .foregroundColor(.textMuted)
                Spacer()
                Text(\"\\(formatDuration(workout.durationSeconds ?? 0))\")
                    .font(.caption)
                    .foregroundColor(.textMuted)
            }
        }
        .padding(.vertical, 8)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    func formatDuration(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return \"\\(mins):\\(String(format: \"%02d\", secs))\"
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
