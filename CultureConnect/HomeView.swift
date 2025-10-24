import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Home")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationTitle("CultureConnect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
