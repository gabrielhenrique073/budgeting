import SwiftUI
import CoreData

struct SettingsView: View {
    
    private var context: NSManagedObjectContext
    
    @State private var model: SettingsModel
    
    @State private var isDataRemovalDialogPresented = false
    
    @AppStorage("showPastBills") private var showPastBills = true
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        _model = State(
            initialValue: SettingsModel(
                context: context
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Resources"),
                    footer: Text("Manage your resources like the categories"),
                    content: {
                        NavigationLink (
                            destination: {
                                CategoriesView(context: context)
                            },
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
                    header: Text("Coming Up"),
                    footer: Text("If toggled you will see in the coming up sections the bills that are 2 days past. This might be helpfull so you can make sure you are not missing anything."),
                    content: {
                        Toggle(
                            isOn: $showPastBills,
                            label: {
                                Label(
                                    title: {
                                        Text("Show past bills")
                                    },
                                    icon: {
                                        Image(systemName: "clock")
                                            .foregroundColor(.yellow)
                                    }
                                )
                            }
                        )
                    }
                )
                
                Section(
                    header: Text("Erase Data"),
                    footer: Text("Delete all your personal data like your bills, categories and preferences"),
                    content: {
                        Button (
                            action: {
                                isDataRemovalDialogPresented.toggle()
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
            
            .confirmationDialog("Remove Data",
                isPresented: $isDataRemovalDialogPresented,
                actions: {
                    Button(
                        action: {
                            
                            model.deleteData()
                            model.createDefaultCategories()
                            
                            isDataRemovalDialogPresented.toggle()
                        },
                        label: {
                            Text("Yes, remove my data")
                        }
                    )
                },
                message: {
                    Text("Removing your personal data is final and there is no way to recovery it. Are you sure you want to continue?")
                }
            )
            
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
