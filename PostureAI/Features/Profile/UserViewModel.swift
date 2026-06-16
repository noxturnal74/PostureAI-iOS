import Foundation
import Combine

// MARK: - UserViewModel

class UserViewModel: ObservableObject {
    @Published var user: User
    @Published var isLoading = false
    
    private let storage: UserStorage
    
    init(storage: UserStorage = UserStorage()) {
        self.storage = storage
        self.user = User(
            id: \"user1\",
            email: \"user@example.com\",
            displayName: \"Fitness Enthusiast\",
            avatarURL: nil,
            age: 28,
            gender: .male,
            fitnessLevel: .intermediate,
            createdAt: Date()
        )
    }
    
    func updateUser(_ updatedUser: User) async {
        isLoading = true
        do {
            try await storage.saveUser(updatedUser)
            user = updatedUser
            isLoading = false
        } catch {
            print(\"Error updating user: \\(error)\")
            isLoading = false
        }
    }
    
    func signOut() {
        // Handle sign out
    }
}

class UserStorage {
    func saveUser(_ user: User) async throws {
        let data = try JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: \"user\")
    }
    
    func getUser() async throws -> User? {
        guard let data = UserDefaults.standard.data(forKey: \"user\") else { return nil }
        return try JSONDecoder().decode(User.self, from: data)
    }
}
