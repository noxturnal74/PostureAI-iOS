import SwiftUI

struct ProfileView: View {
    @State private var user = User(
        id: \"user1\",
        email: \"user@example.com\",
        displayName: \"Fitness Enthusiast\",
        avatarURL: nil,
        age: 28,
        gender: .male,
        fitnessLevel: .intermediate,
        createdAt: Date()
    )
    
    @State private var showingSettings = false
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Profile Header
                ZStack {
                    Color.accent
                        .ignoresSafeArea()
                    
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: \"person.circle.fill\")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            )
                        
                        Text(user.displayName)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            StatItem(label: \"Workouts\", value: \"47\")
                            Divider()
                                .background(Color.white.opacity(0.3))
                            StatItem(label: \"Minutes\", value: \"1,234\")
                            Divider()
                                .background(Color.white.opacity(0.3))
                            StatItem(label: \"Streak\", value: \"12\")
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                        Spacer()
                    }
                }
                
                // User Info
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(\"Profile\")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                        Spacer()
                        Button(action: { showingEditProfile = true }) {
                            Image(systemName: \"pencil\")
                                .foregroundColor(.accent)
                        }
                    }
                    
                    InfoRow(label: \"Email\", value: user.email)
                    InfoRow(label: \"Age\", value: \"\\(user.age ?? 0)\")
                    InfoRow(label: \"Gender\", value: user.gender?.rawValue.capitalized ?? \"N/A\")
                    InfoRow(label: \"Fitness Level\", value: user.fitnessLevel.rawValue.capitalized)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                // Stats
                VStack(alignment: .leading, spacing: 16) {
                    Text(\"Statistics\")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, 16)
                    
                    VStack(spacing: 0) {
                        StatRow(label: \"Average Posture Score\", value: \"87%\", icon: \"checkmark.seal.fill\", color: .success)
                        Divider()
                        StatRow(label: \"Total Reps\", value: \"1,234\", icon: \"repeat.circle.fill\", color: .accent)
                        Divider()
                        StatRow(label: \"Calories Burned\", value: \"50K\", icon: \"flame.fill\", color: .error)
                    }
                    .padding(.vertical, 8)
                }
                .padding(.top, 8)
                
                Spacer()
            }
            .background(Color.secondaryBackground.ignoresSafeArea())
            .navigationTitle(\"Profile\")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSettings = true }) {
                        Image(systemName: \"gearshape\")
                            .foregroundColor(.accent)
                    }
                }
            }
            .sheet(isPresented: ) {
                EditProfileView(user: )
            }
            .sheet(isPresented: ) {
                SettingsView()
            }
        }
    }
}

struct StatItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subhead)
                .foregroundColor(.textMuted)
            Spacer()
            Text(value)
                .font(.subhead)
                .foregroundColor(.textPrimary)
        }
        .padding(.vertical, 8)
    }
}

struct StatRow: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            Text(label)
                .font(.body)
                .foregroundColor(.textSecondary)
            Spacer()
            Text(value)
                .font(.body)
                .bold()
                .foregroundColor(.textPrimary)
        }
        .padding(.horizontal, 16)
    }
}

struct EditProfileView: View {
    @Binding var user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(\"Personal Information\")) {
                    TextField(\"Display Name\", text: .displayName)
                    TextField(\"Email\", text: .email)
                        .keyboardType(.emailAddress)
                    
                    Picker(\"Gender\", selection: .gender) {
                        Text(\"Male\").tag(User.Gender.male)
                        Text(\"Female\").tag(User.Gender.female)
                        Text(\"Other\").tag(User.Gender.other)
                        Text(\"Prefer not to say\").tag(User.Gender.preferNotToSay)
                    }
                    
                   stepper.value = Double(user.age ?? 0)
                    Stepper(\"Age: \\(Int(stepper.value))\", value: .value, in: 18...100)
                    user.age = Int(stepper.value)
                }
                
                Section(header: Text(\"Fitness Level\")) {
                    Picker(\"Fitness Level\", selection: .fitnessLevel) {
                        Text(\"Beginner\").tag(User.FitnessLevel.beginner)
                        Text(\"Intermediate\").tag(User.FitnessLevel.intermediate)
                        Text(\"Advanced\").tag(User.FitnessLevel.advanced)
                    }
                }
            }
            .navigationTitle(\"Edit Profile\")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(\"Save\") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    @State private var stepper = Double(28)
}

struct SettingsView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: Text(\"Notifications Settings\")) {
                    Label(\"Notifications\", systemImage: \"bell.fill\")
                }
                NavigationLink(destination: Text(\"Privacy Settings\")) {
                    Label(\"Privacy\", systemImage: \"lock.fill\")
                }
                NavigationLink(destination: Text(\"Data Settings\")) {
                    Label(\"Data & Privacy\", systemImage: \"database.fill\")
                }
            }
            
            Section {
                NavigationLink(destination: Text(\"Help & Support\")) {
                    Label(\"Help & Support\", systemImage: \"questionmark.circle.fill\")
                }
                NavigationLink(destination: Text(\"Terms of Service\")) {
                    Label(\"Terms of Service\", systemImage: \"doc.text.fill\")
                }
                NavigationLink(destination: Text(\"Privacy Policy\")) {
                    Label(\"Privacy Policy\", systemImage: \"doc.text.fill\")
                }
            }
            
            Section {
                Button(action: {}) {
                    Label(\"Sign Out\", systemImage: \"rectangle.portrait.and.arrow.right\")
                }
            }
        }
        .navigationTitle(\"Settings\")
        .listStyle(PlainListStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
