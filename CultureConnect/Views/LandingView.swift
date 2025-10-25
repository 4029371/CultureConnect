import SwiftUI

struct LandingView: View {
    let onLoginSuccess: () -> Void
    let onSignupSuccess: () -> Void
    
    var body: some View {
        ZStack {
            // Brand gradient background
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 20)
                
                // White rounded container for the landing content
                VStack(spacing: 32) {
                    
                    // Branding / hero
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 88, height: 88)
                                .shadow(radius: 12, y: 8)
                            
                            Image(systemName: "globe.americas.fill")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(.white)
                                .accessibilityHidden(true)
                        }
                        
                        VStack(spacing: 8) {
                            Text("CultureConnect")
                                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                .multilineTextAlignment(.center)
                            
                            Text("Real experiences, from real people.\nAsk anything. Learn respectfully.")
                                .font(.system(.body, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 24)
                        }
                    }
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Sign up
                        NavigationLink {
                            SignupView(
                                onSignupSuccess: {
                                    onSignupSuccess()
                                }
                            )
                        } label: {
                            Text("Get Started")
                                .font(.system(.headline, design: .rounded, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        colors: [Color.blue, Color.purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 10, y: 6)
                        }
                        .accessibilityIdentifier("signupButton")
                        
                        // Log in
                        NavigationLink {
                            LoginView(
                                onLoginSuccess: {
                                    onLoginSuccess()
                                }
                            )
                        } label: {
                            Text("I already have an account")
                                .font(.system(.headline, design: .rounded, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .strokeBorder(.primary.opacity(0.2), lineWidth: 1)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                .fill(Color.white.opacity(0.9))
                                        )
                                )
                                .foregroundStyle(.primary)
                        }
                        .accessibilityIdentifier("loginButton")
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(Color.white)
                            .shadow(
                                color: Color.black.opacity(0.08),
                                radius: 20,
                                y: 10
                            )
                    )
                    .padding(.horizontal, 24)
                    
                    // Footer
                    VStack(spacing: 4) {
                        Text("Made for students")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("Respect • Curiosity • Belonging")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.bottom, 12)
                }
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.15), radius: 25, y: 10)
                )
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        LandingView(
            onLoginSuccess: {},
            onSignupSuccess: {}
        )
    }
}
