import SwiftUI
import SwiftData
import Foundation

struct Settings: View {
    
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Resources"),
                    content: {
                        NavigationLink(
                            destination: CategoriesList(),
                            label: {
                                Label(
                                    title: { 
                                        Text("Categories")
                                    },
                                    icon: { 
                                        Image(systemName: "list.bullet")
                                            .foregroundColor(.green)
                                    }
                                )
                            }
                        )
                    }
                )
                
                Section(
                    header: Text("Erase Data"),
                    content: {
                        Button(
                            action: {
                                
                                isFirstLaunch.toggle()
                                
                                do {
                                    try modelContext.delete(model: Bill.self)
                                    try modelContext.delete(model: Category.self)
                                    try modelContext.save()
                                } catch {
                                    print("Failed to delete data")
                                }
                            },
                            label: {
                                Label(
                                    title: {
                                        Text("Remove Data")
                                            .foregroundColor(.primary)
                                    },
                                    icon: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                )
                            }
                        )
                    }
                )
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
