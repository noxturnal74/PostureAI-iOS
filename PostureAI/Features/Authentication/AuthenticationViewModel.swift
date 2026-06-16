import Foundation
import Combine

// MARK: - AuthenticationViewModel

class AuthenticationViewModel: ObservableObject {
    @Published var email = \"\"
    @Published var password = \"\"
    @Published var displayName = \"\"
    @Published var isLogin = true
    @Published var showError = false
    @Published var errorMessage = \"\"
    @Published var isLoading = false
    @Published var isAuthenticated = false
    
    func login() async {
        isLoading = true
        showError = false
        
        // Simulate API call
        await Task.sleep(UInt64(1.5 * 1_000_000_000))
        
        if email.isEmpty || password.isEmpty {
            showError = true
            errorMessage = \"Please fill in all fields\"
            isLoading = false
            return
        }
        
        // Validate credentials (placeholder)
        if email.contains(\"@\") && password.count >= 6 {
            isLoading = false
            isAuthenticated = true
            // Store authentication state
        } else {
            showError = true
            errorMessage = \"Invalid email or password\"
            isLoading = false
        }
    }
    
    func register() async {
        isLoading = true
        showError = false
        
        if email.isEmpty || password.isEmpty || displayName.isEmpty {
            showError = true
            errorMessage = \"Please fill in all fields\"
            isLoading = false
            return
        }
        
        await Task.sleep(UInt64(1.5 * 1_000_000_000))
        
        if email.contains(\"@\") && password.count >= 6 {
            isLoading = false
            isAuthenticated = true
        } else {
            showError = true
            errorMessage = \"Invalid registration information\"
            isLoading = false
        }
    }
    
    func signOut() {
        isAuthenticated = false
    }
}
