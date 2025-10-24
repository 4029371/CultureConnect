import SwiftUI

struct ExploreTabView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Explore")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))

            Text("This will be your For You / swipe feed.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ExploreTabView()
}
