import Foundation
import SwiftUI

struct Comment: Identifiable, Hashable {
    let id: UUID
    var authorDisplayName: String
    var body: String
    var timestamp: Date
}
