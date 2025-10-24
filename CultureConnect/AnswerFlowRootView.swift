import SwiftUI

struct AnswerFlowRootView: View {
    @State private var path: [AnswerRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Contribute") {
                    // Answer an existing question
                    NavigationLink(value: AnswerRoute.pickQuestion) {
                        HStack {
                            Image(systemName: "text.bubble.fill")
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text("Answer an existing question")
                                    .font(.headline)
                                Text("Browse what people want to know right now")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    // Share your own perspective
                    NavigationLink(value: AnswerRoute.writeCustomAnswer) {
                        HStack {
                            Image(systemName: "pencil.and.outline")
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("Share your own perspective")
                                    .font(.headline)
                                Text("Write your own headline and answer it")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Answer")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AnswerRoute.self) { route in
                switch route {
                case .pickQuestion:
                    PickQuestionToAnswerView(path: $path)
                case .writeCustomAnswer:
                    CustomAnswerComposerView()
                case .composeForQuestion(let question):
                    AnswerComposerView(question: question)
                }
            }
        }
    }
}

// All the navigation states
enum AnswerRoute: Hashable {
    case pickQuestion
    case writeCustomAnswer
    case composeForQuestion(Question)
}

#Preview {
    AnswerFlowRootView()
        .environmentObject(PostStore())
        .environmentObject(QuestionStore())
}
