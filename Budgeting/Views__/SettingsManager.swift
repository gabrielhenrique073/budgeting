import SwiftUI
import Foundation
import CoreData

struct SettingsManager: View {
    
    var body: some View {
        NavigationStack {
            
            // Context
            List {
                Section(
                    header: Text("Resources"),
                    footer: Text("Manage your resources like categories"),
                    content: {
                        
                        // Categories
                        NavigationLink (
                            destination: CategoriesManager(),
                            label: {
                                Label(
                                    title: {
                                        Text("Categories")
                                            .foregroundColor(.primary)
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
                    footer: Text("Removing your data is final and there is no way back"),
                    content: {
                        
                        // Remove Data
                        Button(
                            action: {
                                
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
            
            // Title
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
