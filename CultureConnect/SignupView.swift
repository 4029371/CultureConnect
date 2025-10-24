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
