import Foundation

struct Post: Identifiable, Hashable {
    let id: UUID
    
    // Content
    var title: String
    var body: String
    
    // Author
    var authorDisplayName: String
    var authorCulturalTag: String
    var authorUniversity: String?
    
    // Meta
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
        Post(
            id: UUID(),
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
                    body: "Wait is nasi lemak the thing wrapped in banana leaf?? I had that once at Queen Vic Market it slapped",
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
        Post(
            id: UUID(),
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
        )
    ]
}
