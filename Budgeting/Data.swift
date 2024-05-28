import CoreData

class Data: ObservableObject {
    static let shared = Data()
    
    lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load database")
            }
        }
        return container
    }()
        
    private init() { }
}
