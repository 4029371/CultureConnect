import Foundation
import SwiftUI

struct Question: Identifiable, Hashable {
    let id: UUID
    var text: String              // the actual question being asked
    var category: PostCategory    // same categories (Food, Language, etc.)
    
    var askedByDisplayName: String   // e.g. "Jess 🇦🇺"
    var askedByUniversity: String?   // optional
    var timestamp: Date
    
    // Later you can add: isAnonymous, isReported, etc.
}

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
            askedByUniversity: nil,
            timestamp: Date(timeIntervalSinceNow: -7200)
        )
    ]
}
