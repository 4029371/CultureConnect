import SwiftUI

struct AccountTabView: View {
    @State private var goLanding = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Hidden nav link to go back to LandingView
            NavigationLink(
                destination: LandingView()
                    .navigationBarBackButtonHidden(true),
                isActive: $goLanding
            ) {
                EmptyView()
            }
            .hidden()
            
            Text("Account")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Text("Log out to return to the welcome screen.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                goLanding = true
            } label: {
                Text("Log Out")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.red.opacity(0.9), Color.red.opacity(0.6)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, y: 6)
                    .padding(.horizontal, 24)
            }
            .accessibilityIdentifier("logoutButton")
            
            Spacer()
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        AccountTabView()
    }
}
