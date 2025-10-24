import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    // Controls navigation to HomeView
    @State private var goHome: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Invisible nav link that becomes active when goHome = true
                NavigationLink(
                    destination: HomeView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $goHome
                ) {
                    EmptyView()
                }
                .hidden()
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.system(.title, design: .rounded, weight: .bold))

                    Text("Good to see you again 👋")
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                
                // Form
                VStack(spacing: 16) {
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
                
                // Log in button -> sets goHome = true
                Button {
                    goHome = true
                } label: {
                    Text("Log In")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    (email.isEmpty || password.isEmpty)
                                    ? LinearGradient(
                                        colors: [Color.gray.opacity(0.4), Color.gray.opacity(0.2)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    : LinearGradient(
                                        colors: [Color.blue, Color.purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                        .foregroundColor(.white)
                        .shadow(
                            color: Color.black.opacity(
                                (email.isEmpty || password.isEmpty) ? 0 : 0.15
                            ),
                            radius: 10,
                            y: 6
                        )
                }
                .disabled(email.isEmpty || password.isEmpty)
                .padding(.top, 8)
                
                // Forgot password
                Button {
                    print("forgot password tapped")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Log in")
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
        LoginView()
    }
}
