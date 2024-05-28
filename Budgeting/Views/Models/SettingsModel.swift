import CoreData
import SwiftUI

extension SettingsView {
    final class SettingsModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func deleteData() {
            deleteCategories()
            deleteBills()
        }
        func createDefaultData() {
            createDefaultCategories()
        }
        
        func deleteCategory(item: Category) {
            context.delete(item)
        }
        func deleteCategories() {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
           
            do {
                let categories = try context.fetch(fetchRequest)
                
                for category in categories {
                    deleteCategory(item: category)
                }
                
                try context.save()
            } catch {
                fatalError("Failed to delete categories")
            }
        }
        func deleteBills() {
            let fetchRequest: NSFetchRequest<Bill> = Bill.fetchRequest()
            
            do {
                let bills = try context.fetch(fetchRequest)
                
                for bill in bills {
                    context.delete(bill)
                }
                
                try context.save()
            } catch {
                fatalError("Failed to delete bills")
            }
        }
        
        func createDefaultCategories() {
            let rent = Category(context: context)
            rent.id = UUID()
            rent.name = "Rent"
            rent.icon = "🛌"
            
            let income = Category(context: context)
            income.id = UUID()
            income.name = "Income"
            income.icon = "💰"
            
            let carInsurance = Category(context: context)
            carInsurance.id = UUID()
            carInsurance.name = "Car Insurance"
            carInsurance.icon = "🚗"
            
            let dentalInsurance = Category(context: context)
            dentalInsurance.id = UUID()
            dentalInsurance.name = "Dental Insurance"
            dentalInsurance.icon = "🦷"
            
            let petInsurance = Category(context: context)
            petInsurance.id = UUID()
            petInsurance.name = "Pet Insurance"
            petInsurance.icon = "🐶"
            
            let houseInsurance = Category(context: context)
            houseInsurance.id = UUID()
            houseInsurance.name = "House Insurance"
            houseInsurance.icon = "🏡"
            
            let groceries = Category(context: context)
            groceries.id = UUID()
            groceries.name = "Groceries"
            groceries.icon = "🥩"
            
            let entertainment = Category(context: context)
            entertainment.id = UUID()
            entertainment.name = "Entertainment"
            entertainment.icon = "🎉"
            
            let morgage = Category(context: context)
            morgage.id = UUID()
            morgage.name = "Morgage"
            morgage.icon = "🏦"
            
            let utilities = Category(context: context)
            utilities.id = UUID()
            utilities.name = "Utilities"
            utilities.icon = "💡"
            
            let transportation = Category(context: context)
            transportation.id = UUID()
            transportation.name = "Transportation"
            transportation.icon = "⛽️"
            
            do {
                try context.save()
            } catch {
                fatalError("Failed to create default categories")
            }
        }
    }
}
