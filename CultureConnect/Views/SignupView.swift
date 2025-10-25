import SwiftUI

struct SignupView: View {
    let onSignupSuccess: () -> Void
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var canContinue: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Create your account")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Join CultureConnect!")
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                
                // Form
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Name")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        TextField("Your display name", text: $name)
                            .textInputAutocapitalization(.words)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        TextField("you@student.university.edu", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
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
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                    }
                }
                
                // Continue / Create account button
                Button {
                    onSignupSuccess()
                } label: {
                    Text("Create Account")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    canContinue
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
                        .shadow(
                            color: Color.black.opacity(canContinue ? 0.15 : 0),
                            radius: 10,
                            y: 6
                        )
                }
                .disabled(!canContinue)
                .padding(.top, 8)
                
                Text("By continuing you confirm you're here to listen, learn, and contribute respectfully.")
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
}

#Preview {
    NavigationStack {
        SignupView(onSignupSuccess: {})
    }
}
