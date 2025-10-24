import SwiftUI

struct SignupView: View {
    @State private var displayName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var backgroundInfo: String = ""
    @State private var agreeToGuidelines: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Header / pitch
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
                    // Display name
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
                    
                    // Email
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
                    
                    // Password
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
                    
                    // Cultural background / identity
                    VStack(alignment: .leading, spacing: 6) {
                        Text("How do you identify culturally?")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        TextField("e.g. Malaysian-Chinese, first-gen international student", text: $backgroundInfo, axis: .vertical)
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
            }
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
        SignupView()
    }
    .preferredColorScheme(.light)
}
