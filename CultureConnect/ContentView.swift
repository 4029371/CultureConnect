import SwiftUI

struct ContentView: View {
    @StateObject private var postStore = PostStore()
    
    var body: some View {
        NavigationStack {
            LandingView()
        }
        .environmentObject(postStore)
    }
}

#Preview {
    ContentView()
}
