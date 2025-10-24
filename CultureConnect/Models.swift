import Foundation
import SwiftUI

struct Post: Identifiable, Hashable {
    let id: UUID
    
    // Link back to the question
    var questionID: UUID
    var questionText: String      // copy of the question at time of answer
    
    // Core content
    var title: String             // short hook/headline for the answer
    var body: String              // the answer content
    
    // Author info
    var authorDisplayName: String
    var authorCulturalTag: String
    var authorUniversity: String?
    
    // Meta / trust
    var category: PostCategory
    var timestamp: Date
    var isVerified: Bool
    
    // Social
    var likeCount: Int
    var commentCount: Int
    var comments: [Comment]
    
    // Moderation
    var isReported: Bool
}

struct Comment: Identifiable, Hashable {
    let id: UUID
    var authorDisplayName: String
    var body: String
    var timestamp: Date
}

// Filtering
enum PostCategory: String, CaseIterable, Codable, Hashable {
    case language     = "Language"
    case food         = "Food"
    case events       = "Events"
    case music        = "Music"
    case general      = "General"
    case uniLife      = "Uni Life"
}

// Seed data
extension Post {
    static let samplePosts: [Post] = [
        // FOOD
        Post(
            id: UUID(),
            questionID: UUID(),
            questionText: "What do people usually eat for breakfast in Malaysia?",
            title: "Do Malaysians actually eat spicy food for breakfast??",
            body: """
                Yes. Nasi lemak is literally coconut rice + sambal (chili paste) and we eat it at 8am before class.

                When I first moved here people were like “how are you eating chilli this early” and I was like “how are you eating cereal with no seasoning.”

                But also: not every region eats it super spicy. My family tones it down a bit because my mum can’t handle heat.
                """,
            authorDisplayName: "Aisha 🇲🇾",
            authorCulturalTag: "Malaysian-Chinese • International student",
            authorUniversity: "RMIT University",
            category: .food,
            timestamp: Date(timeIntervalSinceNow: -3600),
            isVerified: true,
            likeCount: 128,
            commentCount: 5,
            comments: [
                Comment(
                    id: UUID(),
                    authorDisplayName: "Tom (Local)",
                    body: "Wait is nasi lemak the thing wrapped in banana leaf?? I had that once at Queen Vic Market—it slapped!",
                    timestamp: Date(timeIntervalSinceNow: -1800)
                ),
                Comment(
                    id: UUID(),
                    authorDisplayName: "Aisha 🇲🇾",
                    body: "Yes!! That’s the legit way, not the plastic container version lol",
                    timestamp: Date(timeIntervalSinceNow: -1200)
                )
            ],
            isReported: false
        ),
        
        // LANGUAGE
        Post(
            id: UUID(),
            questionID: UUID(),
            questionText: "Is it rude to try to speak another language if you're not fluent?",
            title: "Is it rude to try to speak Japanese if you're not good at it?",
            body: """
                Short answer: No. We think it's cute and respectful 90% of the time.

                The only time it's weird is if you ignore when we try to switch to English to help you, and you keep forcing it like it's a performance.

                So: try, but also read the vibe.
                """,
            authorDisplayName: "Rin 🇯🇵",
            authorCulturalTag: "Tokyo-born • Exchange student",
            authorUniversity: "UniMelb",
            category: .language,
            timestamp: Date(timeIntervalSinceNow: -7200),
            isVerified: true,
            likeCount: 302,
            commentCount: 12,
            comments: [],
            isReported: false
        ),
        
        // EVENTS
        Post(
            id: UUID(),
            questionID: UUID(),
            questionText: "What’s a big cultural festival you celebrate back home?",
            title: "How we celebrate Diwali in India 🇮🇳",
            body: """
                It’s more than lights - it’s about cleaning the home, decorating with rangoli, visiting relatives, and eating *a lot* of sweets.

                Here in Melbourne, we try to recreate it by cooking together in our sharehouse and video calling our families.

                The feeling of home comes back for a bit, even with cheap fairy lights from Kmart 😅.
                """,
            authorDisplayName: "Ananya 🇮🇳",
            authorCulturalTag: "Indian • International student",
            authorUniversity: "Monash University",
            category: .events,
            timestamp: Date(timeIntervalSinceNow: -10800),
            isVerified: true,
            likeCount: 214,
            commentCount: 9,
            comments: [],
            isReported: false
        ),
        
        // MUSIC
        Post(
            id: UUID(),
            questionID: UUID(),
            questionText: "What kind of music reminds you of home?",
            title: "K-Pop isn’t just pop — it’s a comfort blanket 🎵",
            body: """
                When I first came to Australia, I played old IU and Epik High songs to fall asleep. It’s not about lyrics, it’s about familiarity.

                Music in your own language feels like being hugged by home after a long day.
                """,
            authorDisplayName: "Jin 🇰🇷",
            authorCulturalTag: "Korean • Exchange student",
            authorUniversity: "RMIT University",
            category: .music,
            timestamp: Date(timeIntervalSinceNow: -14400),
            isVerified: true,
            likeCount: 187,
            commentCount: 4,
            comments: [],
            isReported: false
        ),
        
        // UNI LIFE
        Post(
            id: UUID(),
            questionID: UUID(),
            questionText: "What’s the hardest part about studying abroad?",
            title: "Adjusting to how casual professors are here 😅",
            body: """
                Back home, we’d never call a lecturer by their first name - here, everyone’s like “Hey Dave!”

                It took me weeks to stop bowing slightly when leaving tutorials 😭. Now I love the chill vibe though.
                """,
            authorDisplayName: "Yuki 🇯🇵",
            authorCulturalTag: "Japanese • Engineering student",
            authorUniversity: "RMIT University",
            category: .uniLife,
            timestamp: Date(timeIntervalSinceNow: -18000),
            isVerified: true,
            likeCount: 256,
            commentCount: 3,
            comments: [],
            isReported: false
        ),
        
        // GENERAL
        Post(
            id: UUID(),
            questionID: UUID(),
            questionText: "What’s something people often misunderstand about your culture?",
            title: "Being quiet doesn’t mean being shy",
            body: """
                In my culture, listening is a sign of respect — we wait before jumping into conversation. 

                Some locals thought I was shy or uninterested, but I just didn’t want to interrupt. I’ve learned to balance both styles now.
                """,
            authorDisplayName: "Farah 🇮🇩",
            authorCulturalTag: "Indonesian • Master’s student",
            authorUniversity: "University of Melbourne",
            category: .general,
            timestamp: Date(timeIntervalSinceNow: -21600),
            isVerified: true,
            likeCount: 341,
            commentCount: 14,
            comments: [],
            isReported: false
        )
    ]
}


extension PostCategory {
    var color: Color {
        switch self {
        case .language:   return .teal
        case .food:       return .orange
        case .events:     return .pink
        case .music:      return .purple
        case .general:    return .gray
        case .uniLife:    return .blue
        }
    }
}

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
