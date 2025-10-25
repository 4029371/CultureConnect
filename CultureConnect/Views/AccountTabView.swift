import SwiftUI

struct AccountTabView: View {
    // MARK: - Properties
    let onLogout: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            // Header / profile stub
            VStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.secondary)
                
                Text("Me 🇦🇺")
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                
                Text("Singaporean-Chinese • Naturalized Australian")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 40)
            
            // Placeholders
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                    Text("Verification status: Pending")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "building.columns")
                        .foregroundColor(.purple)
                    Text("Affiliation: RMIT University")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // Logout button
            Button {
                onLogout()
            } label: {
                Text("Log Out")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.red.opacity(0.9))
                    )
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AccountTabView(onLogout: {})
    }
}
