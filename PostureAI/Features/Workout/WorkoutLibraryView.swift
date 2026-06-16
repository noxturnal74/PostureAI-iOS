import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: ) {
            HomeView()
                .tabItem {
                    Label(\"Home\", systemImage: \"house.fill\")
                }
                .tag(0)
            
            WorkoutLibraryView()
                .tabItem {
                    Label(\"Workouts\", systemImage: \"figure.strength??\")
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    Label(\"History\", systemImage: \"clock.fill\")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label(\"Profile\", systemImage: \"person.fill\")
                }
                .tag(3)
        }
        .accentColor(.accent)
    }
}

struct WorkoutLibraryView: View {
    let exercises: [Exercise] = [
        Exercise(id: \"1\", name: \"Squat\", description: \"Lower body strength\", category: .strength, difficulty: .beginner, instructions: [], correctFormDescription: \"\", commonMistakes: [], caloriesPerMinute: 5.5, muscleGroups: [.legs, .glutes], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
        Exercise(id: \"2\", name: \"Push Up\", description: \"Upper body strength\", category: .strength, difficulty: .intermediate, instructions: [], correctFormDescription: \"\", commonMistakes: [], caloriesPerMinute: 7.0, muscleGroups: [.chest, .shoulders, .triceps], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
        Exercise(id: \"3\", name: \"Bicep Curl\", description: \"Arm strength\", category: .strength, difficulty: .beginner, instructions: [], correctFormDescription: \"\", commonMistakes: [], caloriesPerMinute: 4.0, muscleGroups: [.biceps], requiredEquipment: [\"Dumbbells\"], estimatedDurationSeconds: 45, videoURL: nil, imageURL: nil),
        Exercise(id: \"4\", name: \"Plank\", description: \"Core stability\", category: .core, difficulty: .beginner, instructions: [], correctFormDescription: \"\", commonMistakes: [], caloriesPerMinute: 3.0, muscleGroups: [.abs, .obliques], requiredEquipment: [], estimatedDurationSeconds: 60, videoURL: nil, imageURL: nil),
        Exercise(id: \"5\", name: \"Dumbbell Fly\", description: \"Chest workout\", category: .strength, difficulty: .intermediate, instructions: [], correctFormDescription: \"\", commonMistakes: [], caloriesPerMinute: 5.0, muscleGroups: [.chest], requiredEquipment: [\"Dumbbells\"], estimatedDurationSeconds: 45, videoURL: nil, imageURL: nil),
        Exercise(id: \"6\", name: \"Dumbbell Kickback\", description: \"Triceps workout\", category: .strength, difficulty: .intermediate, instructions: [], correctFormDescription: \"\", commonMistakes: [], caloriesPerMinute: 4.5, muscleGroups: [.triceps], requiredEquipment: [\"Dumbbells\"], estimatedDurationSeconds: 45, videoURL: nil, imageURL: nil)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    NavigationLink(destination: WorkoutDetailsView(exercise: exercise)) {
                        ExerciseRow(exercise: exercise)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.secondaryBackground)
            .navigationTitle(\"Workouts\")
        }
    }
}

struct ExerciseRow: View {
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: \"figure.strength??\")
                .font(.title2)
                .foregroundColor(.accent)
                .frame(width: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.headline)
                HStack {
                    Text(exercise.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.textMuted)
                    Spacer()
                    Text(exercise.difficulty.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .background(Color.border)
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct WorkoutDetailsView: View {
    let exercise: Exercise
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: \"figure.strength??\")
                        .font(.system(size: 64))
                        .foregroundColor(.accent)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: \"heart.fill\")
                            .font(.title2)
                            .foregroundColor(.error)
                    }
                }
                
                Text(exercise.name)
                    .font(.title)
                    .bold()
                
                HStack {
                    Text(exercise.category.rawValue)
                        .font(.subhead)
                        .padding(.horizontal, 8)
                        .background(Color.border)
                        .cornerRadius(4)
                    Text(exercise.difficulty.rawValue)
                        .font(.subhead)
                        .padding(.horizontal, 8)
                        .background(Color.border)
                        .cornerRadius(4)
                    Spacer()
                    Text(\"\\(exercise.caloriesPerMinute) cal/min\")
                        .font(.subhead)
                }
                
                Text(exercise.description)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(\"Instructions\")
                        .font(.headline)
                    
                    ForEach(exercise.instructions, id: \\.self) { instruction in
                        HStack(alignment: .top, spacing: 8) {
                            Text(\"•\")
                            Text(instruction)
                                .font(.body)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(\"Correct Form\")
                        .font(.headline)
                    
                    Text(exercise.correctFormDescription)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(\"Common Mistakes\")
                        .font(.headline)
                    
                    ForEach(exercise.commonMistakes, id: \\.self) { mistake in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: \"exclamationmark.triangle.fill\")
                                .foregroundColor(.error)
                                .frame(width: 20)
                            Text(mistake)
                                .font(.body)
                        }
                    }
                }
                
                Button(action: {}) {
                    Text(\"Start Workout\")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accent)
                        .cornerRadius(12)
                        .padding(.top, 16)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .navigationTitle(exercise.name)
    }
}

struct WorkoutLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
