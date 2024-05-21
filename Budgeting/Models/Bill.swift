import SwiftData
import Foundation

@Model
class Bill: Identifiable {
    
    var id: UUID
    var title: String
    var category: Category
    var amount: Float = 0.0
    var isExpense: Bool = true
    var isRecurrent: Bool = false
    var dueAt: Date = Date.now

    init(title: String, category: Category) {
        self.id = UUID()
        self.title = title
        self.category = category
    }
}
