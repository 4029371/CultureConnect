import SwiftUI
import Combine

class QuestionStore: ObservableObject {
    @Published var questions: [Question]
    
    init(questions: [Question] = Question.sampleQuestions) {
        self.questions = questions
    }
    
    func addQuestion(_ question: Question) {
        // prepend
        questions.insert(question, at: 0)
    }
}
