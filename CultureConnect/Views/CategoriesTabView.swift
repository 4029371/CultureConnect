import SwiftUI

struct CategoriesTabView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Categories")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))

            Text("Here you'll browse by topic:\n• Language\n• Food\n• Events\n• Music\n• General\n…")
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
    CategoriesTabView()
}
