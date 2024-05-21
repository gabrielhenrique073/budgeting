import SwiftData
import Foundation

@Model
class Category: Identifiable {
    var id: UUID
    var name: String
    var icon: String

    init(name: String, icon: String) {
        self.id = UUID()
        self.name = name
        self.icon = icon
    }
}
