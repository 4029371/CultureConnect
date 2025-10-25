import Foundation
import SwiftUI

struct Question: Identifiable, Hashable {
    let id: UUID
    var text: String
    var category: PostCategory
    
    var askedByDisplayName: String
    var askedByUniversity: String?
    var timestamp: Date
}

// MARK: - Question Samples
extension Question {
    static let sampleQuestions: [Question] = [
        Question(
            id: UUID(),
            text: "What’s something international students wish locals understood about fasting during Ramadan?",
            category: .general,
            askedByDisplayName: "Liam 🇦🇺",
            askedByUniversity: "UniMelb",
            timestamp: Date(timeIntervalSinceNow: -3600)
        ),
        Question(
            id: UUID(),
            text: "Is it rude to speak bad Japanese or is it appreciated if I try?",
            category: .language,
            askedByDisplayName: "Emily 🇦🇺",
            askedByUniversity: "Monash",
            timestamp: Date(timeIntervalSinceNow: -7200)
        )
    ]
}
