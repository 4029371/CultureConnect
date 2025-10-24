import SwiftUI

struct ContentView: View {
    @StateObject private var postStore = PostStore()
    @StateObject private var questionStore = QuestionStore()
    
    var body: some View {
        NavigationStack {
            LandingView()
        }
        .environmentObject(postStore)
        .environmentObject(questionStore)
    }
}

#Preview {
    ContentView()
}
