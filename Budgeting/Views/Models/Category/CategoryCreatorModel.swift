import CoreData
import SwiftUI

extension CategoryCreatorView {
    final class CategoryCreatorModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func create(name: String, icon: String) {
            
            let item = Category(context: context)
            item.id = UUID()
            item.name = name
            item.icon = icon
            
            do {
               try context.save()
            } catch {
                fatalError("Failed to create category")
            }
        }
    }
}
