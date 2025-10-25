# PART A: Project Responses
## Team Name
Team CultureConnect

## Members
- Donovan Ong (4029371)

## Project Scope (A1, A2, A3)
In response to the prompt "University Problems", CultureConnect explored the issue of racism and discrimination within universities. While racism and discrimination are far from limited to university settings, they remain a growing concern - evidenced by efforts such as the first Racism@Uni national survey run by the Australian Human Rights Commission and the recent launch of RMIT's Anti-Racism Commitment Statement and Action Plan earlier this year.

Completely resolving such a systemic and deeply rooted issue is, of course, beyond the scope of this project. However, by honing in on some of the underlying causes of racism and discrimination within universities, CultureConnect aims to move the needle in the right direction. In particular, the lack of understanding and communication between students from different backgrounds was identified as a key factor. This is the gap CultureConnect seeks to bridge - by creating a platform where verified students can ask, answer, and share bite-sized questions and experiences to gradually foster mutual understanding.

For example, consider the persona of Brody - a student from rural Victoria who has lived his entire life in a small town near the NSW border. Now attending RMIT in Melbourne's CBD, he finds himself surrounded by new cultures, foods, and perspectives he has never encountered before. For a student like Brody, CultureConnect provides a safe space to ask questions about unfamiliar cultures and share his own perspective on rural life. In doing so, cultural exchange occurs naturally - reducing misunderstanding, miscommunication, and the resulting avoidance or discrimination that too often follow.

That said, the idea of asking, answering, and sharing posts draws inspiration from social media, and with that comes risk - including potential hate speech, trolling, harassment, or misinformation. To mitigate this, any real-world implementation would require robust moderation systems, combining AI tools with human oversight.

Another consideration relevant to Australia is the recent social media ban for users under 16. While university students are generally above this threshold, any implementation would still need to address user authentication and data security. This remains out of scope for the current prototype but represents an important future direction.

Interestingly, this same regulation also presents an opportunity. By requiring verified student accounts, CultureConnect not only ensures authenticity but also reduces the likelihood of harmful or anonymous behaviour. Moreover, it emphasizes that the platform is by real students, for real students - offering genuine, relatable perspectives rather than algorithmically generated or impersonal search results.
## Future Development
1. Backend Integration:
Implement a persistent backend service (e.g. Firebase, Supabase, or custom API) to store posts, comments, and user data. This would enable real-time updates, multi-user functionality, and session persistence across devices.

2. Verified User System:
Introduce secure account verification to confirm student identity and age. This ensures accountability and aligns with new social media age-verification regulations in Australia.

3. Moderation Tools:
Add an automated and human-in-the-loop moderation pipeline to detect and manage hate speech, offensive language, and spam content before publication.

4. Recommendation Algorithm:
Enhance the Explore feed with a ranked recommendation system that prioritises posts based on engagement (likes, comments) and freshness, creating a personalised and dynamic discovery experience.

## Design Intentions (C1, C2)
- Designed in swiftUI, the app aimed to stay true to native iOS design principles (Human Interface Guidelines).
- Solution aims to be intuitive but supporting common gestures (e.g. tapping on elements).
- Branding focused around the use of colour, with a signature blue-purple gradient shown in key pages such as the Landing page and various important buttons such as Log In and Sign Up.
- The app also aimed to be intuitive and user-friendly, with a focus on simplicity and minimalism.
- In terms of user experience, the project took inspiration from apps that were popular with the demographic: TikTok, Instagram Reels, X, YouTube Shorts and so on.
- Supporting short-form media was a key design principle, which materialized most clearly in the "Explore" page, which features TikTok-like vertical page scrolling.
- While designing a recommendation algorithm was not in scope for the current stage, the intention was to have the feed slowly show posts that the user would most likely interact with.
- Support for accessibility relied on native support from Apple screenreader software.

## Development Solutions (D2)
1. Provide an example of a well-designed backend function or module that demonstrates efficient time complexity, clean logic, and integration with other components.

While a full running server backend has not yet been implemented, one example of equivalent backend domain logic can be found in PostStore:
- PostStore acts as the app's in-memory backend.
    - All post data lives here (@Published var posts).
    - Views never mutate posts directly. They call PostStore methods like addComment and incrementLikes.
    - This is clean separation of concerns: UI only asks for intent (add a comment to this post), not how to do it.

- Each function is:
    - Time-efficient: firstIndex(where:) is O(n) over the posts array, which is acceptable at our demo scale. There's no unnecessary copying of arrays.
    - Consistent: updates both comments and commentCount in one place, so the rest of the UI stays in sync.

- It integrates across components:
    - FullScreenPostView calls postStore.incrementLikes(for: post.id) when you tap the like button.
    - CommentsSheetView calls postStore.addComment(...).
    - AnswerComposerView calls postStore.addPost(newPost) after you answer a question.

2. Suggest a way to add complexity or scalability to the project through improved algorithms, APIs, codebase enhancements, etc.

- Currently all content (posts, comments, likes) is stored in-memory on device for demo purposes. A scalable architecture would replace PostStore with a network-backed data service that syncs with a remote database. Each PostStore method (e.g. addComment, incrementLikes) would become an async API call. This would allow persistence across sessions, multi-user interaction, and real moderation controls.

- To reduce harassment and culturally harmful content, we can introduce a moderation pipeline into the content creation flow. Before a new post or comment is accepted into PostStore, the text would be screened for hate speech, slurs, personal attacks, or targeted harassment. High-risk content is either blocked immediately or queued for manual review. This is essential for CultureConnect's goal (building empathy instead of hostility) and aligns with the "verified voices" safety model described in the project scope.

## Technologies Used (D3)

# PART B: Setup and User Guide
Requirements:
- macOS 13 or later
- Xcode 15 or later
- Swift 5.9+
- iOS 17+ (Simulator or real device)

Steps:
1. Clone repository.
2. Open the project in Xcode.
3. Select a simulator (e.g. iPhone 16 Pro).
4. Run the app (press the play/run button).

Usage:
- Home: Browse the feed of posts shared and answered by users, vertical scroll with proposed recommendation algorithm.
- Categories: Filter posts by category or search by title/question.
- Ask a Question: post a question for another user to answer.
- Answer a Question: Answer a question another user has asked.
- Interactions: Tap icons to like, comment or share posts.
- Account: View your profile and logout.

# PART C: References
1. Australian Human Rights Commission, Racism. It Stops With Me: Racism@Uni National Survey, 2025. [Online]. Available: https://humanrights.gov.au/racismuni-survey

2. RMIT University, RMIT Anti-Racism Commitment Statement and Action Plan, July 2025. [Online]. Available: https://www.rmit.edu.au/students/news/2025/jul/anti-racism-commitment-statement-action-plan