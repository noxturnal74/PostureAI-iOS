import SwiftUI

struct AuthenticationView: View {
    @State private var email = \"\"
    @State private var password = \"\"
    @State private var isLogin = true
    @State private var showError = false
    @State private var errorMessage = \"\"
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                // Logo and Title
                VStack(spacing: 16) {
                    Image(systemName: \"sparkles.person\")
                        .font(.system(size: 64))
                        .foregroundColor(.accent)
                    Text(\"PostureAI\")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.textPrimary)
                    Text(\"Your AI Fitness Coach\")
                        .font(.headline)
                        .foregroundColor(.textSecondary)
                }
                
                // Form
                VStack(spacing: 16) {
                    if !isLogin {
                        TextField(\"Full Name\", text: )
                            .textInputAutocapitalization(.words)
                            .disableAutocorrection(true)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                            .background(Color.secondarySurface)
                            .cornerRadius(CornerRadius.md)
                    }
                    
                    TextField(\"Email\", text: )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(Color.secondarySurface)
                        .cornerRadius(CornerRadius.md)
                    
                    SecureField(\"Password\", text: )
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(Color.secondarySurface)
                        .cornerRadius(CornerRadius.md)
                }
                .padding(.horizontal, Spacing.lg)
                
                // Error Message
                if showError {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.error)
                        .padding(.horizontal, Spacing.lg)
                }
                
                // Buttons
                VStack(spacing: 16) {
                    Button(action: handleAction) {
                        Text(isLogin ? \"Sign In\" : \"Create Account\")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, Spacing.sm)
                            .frame(maxWidth: .infinity)
                            .background(Color.accent)
                            .cornerRadius(CornerRadius.md)
                    }
                    .padding(.horizontal, Spacing.lg)
                    
                    if isLogin {
                        Text(\"Forgot Password?\")
                            .font(.subhead)
                            .foregroundColor(.accent)
                    }
                }
                
                // Toggle Login/Register
                HStack justifyContent: .center {
                    Text(isLogin ? \"Don't have an account? \" : \"Already have an account? \")
                        .font(.subhead)
                        .foregroundColor(.textSecondary)
                    Button(action: { isLogin.toggle() }) {
                        Text(isLogin ? \"Sign Up\" : \"Sign In\")
                            .font(.subhead)
                            .foregroundColor(.accent)
                    }
                }
                .padding(.top, 8)
                
                Spacer()
                
                // Social Login
                VStack(spacing: 12) {
                    Divider()
                        .background(Color.border)
                    
                    HStack {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: \"apple.logo\")
                                    .foregroundColor(.textPrimary)
                                Text(\"Continue with Apple\")
                                    .font(.subhead)
                            }
                            .foregroundColor(.textPrimary)
                            .padding(.vertical, Spacing.sm)
                            .frame(maxWidth: .infinity)
                            .background(Color.secondarySurface)
                            .cornerRadius(CornerRadius.md)
                        }
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: \"g.fill\")
                                    .foregroundColor(.textPrimary)
                                Text(\"Continue with Google\")
                                    .font(.subhead)
                            }
                            .foregroundColor(.textPrimary)
                            .padding(.vertical, Spacing.sm)
                            .frame(maxWidth: .infinity)
                            .background(Color.secondarySurface)
                            .cornerRadius(CornerRadius.md)
                        }
                    }
                    .padding(.horizontal, Spacing.lg)
                }
                .padding(.bottom, Spacing.lg)
            }
        }
    }
    
    func handleAction() {
        // Validate and handle authentication
        if email.isEmpty || (!isLogin && password.isEmpty) {
            showError = true
            errorMessage = \"Please fill in all fields\"
            return
        }
        showError = false
        // Proceed with authentication
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
