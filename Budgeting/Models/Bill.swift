import SwiftData
import Foundation

@Model
class Bill: Identifiable {
    
    var id: UUID
    var title: String
    var category: Category
    var flow = Flow.expense
    var creation = Date.now
    var interval: Int = 1
    var frequency = Frequency.monthly
    var recurrence = Recurrence.indeterminate
    var amount: Float = 0.0
    var date = Date.now
    
    init(
        title: String,
        category: Category,
        flow: Flow,
        interval: Int,
        frequency: Frequency,
        recurrence: Recurrence,
        amount: Float,
        date: Date
    ) {
        self.id = UUID()
        self.creation = Date.now
        self.title = title
        self.category = category
        self.flow = flow
        self.interval = interval
        self.frequency = frequency
        self.recurrence = recurrence
        self.amount = amount
        self.date = date
    }
}
