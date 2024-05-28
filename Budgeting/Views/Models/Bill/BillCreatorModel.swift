import CoreData
import SwiftUI

extension BillCreatorView {
    final class BillCreatorModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }

        func create(name: String, amount: Float, category: Category, isEndless: Bool, nextDueAt: Date, interval: Int, period: Period) {
            
            let item = Bill(context: context)
            item.id = UUID()
            item.createdAt = Date.now
            item.name = name
            item.amount = amount
            item.category = category
            item.isEndless = isEndless
            item.nextDueAt = nextDueAt
            item.interval = interval.toInt32
            item.period = period.rawValue.toInt32
            
            do {
               try context.save()
            } catch {
                fatalError("Failed to create bill")
            }
        }
    }
}
