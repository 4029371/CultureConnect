import Foundation

enum AnswerRoute: Hashable {
    case pickQuestion
    case writeCustomAnswer
    case composeForQuestion(Question)
}
