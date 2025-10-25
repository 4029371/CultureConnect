# PART A: Project Responses
## Team Name
Team CultureConnect

## Members
- Donovan Ong (4029371)

## Project Scope (A1, A2, A3)
In response to the prompt "University Problems", CultureConnect took a deeper look at the issue of Racism and Discrimination within universisties. While racism and discrimination are far from restricted to university settings, it is without a doubt a growing concern, evidenced by efforts such as the first "Racism@Uni" national survey on racism in universities run by the Australian Human Rights Commission and the commencement of RMIT's Anti-racism Commitment Statement and Action Plan occuring earlier this year.

To completely resolve this highly systemic and pervasive issue is simply out of scope for the project at this stage. However, by honing in on some of the root causes of racism and discrimination in univerisities, I hoped to move the needle in the right direction. Specfically, I saw the lack of understanding between students of different backgrounds to be a key factor for misunderstanding and miscommunication. This was the gap that CultureConnect aimed to bridge. Through creating a platform where verified students could ask, answer and share questions in small bite-sized chunks, the app could gradually build mutual understanding between students.

Take for instance the persona of Brody - He is a student coming from rural Victoria, having lived his entire life in a single town close to the border of NSW. Now attending RMIT in Melbourne's CBD, he is surrounded by cultures, foods, events and beliefs he has never had the opportunity to learn of or experience before. For a student such as Brody, CultureConnect represents an opportunity to ask questions about these new cultures, while providing his own perspective on what a rural Australian might think of some issue or celebrate some event. In doing so, cultural exchange between students is achieved, alleviated misunderstandings and miscommunications that often lead to avoidance, discrimination, or worse.

The most significant risk to the idea are the aspects borrowed from social media - the idea of asking, answering and sharing posts itself is not new, and where users can freely post opinions, there is always a risk for hate speech, trolling, harrassment, misleading answers and so on. To mitigate this, any real implementation would require more consideration in moderation, both in tools (AI) and human-in-the-loop processes.

Additionally, pertinent to Australia is the recent social media ban for under 16s. While the audience of university students is likely to be beyond this restriction, the need to wrangle with a method for authenticating users and ensuring personal data is secure is a critical task, however remains out of scope for the project at this stage.

It should be noted however that the social media ban that necessitates user verification was also an opportunity for the app - by requiring users to be verified, likelihood of hate speech, trolling and harassment is reduced. Additionally, the app leans into the idea of responses by real people in contrast to say a google search; you are getting responses from other students likely in similar situations / age groups as you.

## Future Development
- Full backend integration
- Verification of users (age)
- Moderation tooling
- Recommendation algorithm of "Explore page"

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