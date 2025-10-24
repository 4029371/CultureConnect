import SwiftUI

struct SignupView: View {
    @State private var displayName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var backgroundInfo: String = ""
    @State private var agreeToGuidelines: Bool = false
    
    // Navigation trigger
    @State private var goToHome: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Hidden nav link that activates programmatically
                NavigationLink(
                    destination: HomeView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $goToHome
                ) { EmptyView() }
                .hidden()
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Create your account")
                        .font(.system(.title, design: .rounded, weight: .bold))
                    
                    Text("Join respectful cultural discussion. Share what it's really like where you're from.")
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                
                // Form fields
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Display name")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        TextField("e.g. Aisha 🇲🇾", text: $displayName)
                            .textInputAutocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("University email")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        TextField("you@student.university.edu", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        SecureField("••••••••", text: $password)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("How do you identify culturally?")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        TextField(
                            "e.g. Malaysian-Chinese, first-gen international student",
                            text: $backgroundInfo,
                            axis: .vertical
                        )
                        .lineLimit(3, reservesSpace: true)
                        .textInputAutocapitalization(.sentences)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                        )
                        
                        Text("This helps us verify you're sharing from lived experience. You can edit this later.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Guidelines agreement
                Toggle(isOn: $agreeToGuidelines) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("I agree to follow CultureConnect's respect guidelines.")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("No harassment. No slurs. Share lived experience, not stereotypes.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                // Continue button
                Button {
                    // Just go to home with authentication for now
                    goToHome = true
                } label: {
                    Text("Continue")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(agreeToGuidelines && formIsValid
                                      ? LinearGradient(
                                            colors: [Color.blue, Color.purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                      : LinearGradient(
                                            colors: [Color.gray.opacity(0.4), Color.gray.opacity(0.2)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                )
                        )
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(agreeToGuidelines && formIsValid ? 0.15 : 0),
                                radius: 10, y: 6)
                }
                .disabled(!(agreeToGuidelines && formIsValid))
                .accessibilityIdentifier("confirmSignupButton")
                
                Text("By continuing, you confirm you’re comfortable sharing your cultural background for verification. This helps keep answers authentic and safe for everyone.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Sign up")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color(.secondarySystemBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
    
    private var formIsValid: Bool {
        !displayName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty
    }
}

#Preview {
    NavigationStack {
        SignupView()
    }
    .preferredColorScheme(.light)
}
