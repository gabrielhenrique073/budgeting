import SwiftUI
import SwiftData
import Foundation

struct Welcome: View {
    
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    var body: some View {
        NavigationStack {
            Button(
                action: {
                    
                    let categories = [
                        Category(name: "Income", icon: "💰"),
                        
                        Category(name: "Dental Insurance", icon: "🦷"),
                        Category(name: "Health Insurance", icon: "🏥"),
                        Category(name: "Car Insurance", icon: "🚗"),
                        Category(name: "Home Insurance", icon: "🏡"),
                        Category(name: "Pet Insurance", icon: "🐶"),
                    ]
                    
                    for category in categories {
                        modelContext.insert(category)
                    }
                    
                    do {
                        try modelContext.save()
                    } catch {
                        fatalError("Failed to create default categories")
                    }
                    
                    isFirstLaunch.toggle()
                },
                label: {
                    Text("Continue")
                }
            )
        }
    }
}
