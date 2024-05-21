import SwiftUI
import SwiftData

@main
struct Index: App {
    
    private var container: ModelContainer
    
    init() {
        do {
            let url = URL.documentsDirectory.appending(path: "database.sqlite")
            let configuration = ModelConfiguration(url: url)
            container = try ModelContainer(for: Bill.self, Category.self, configurations: configuration)
        } catch {
            fatalError("Failed to initialize database")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Window()
        }
        .modelContainer(container)
    }
}

#Preview {
    
    var container: ModelContainer
    
    do {
        let url = URL.applicationDirectory.appending(path: "database.sqlite")
        let configuration = ModelConfiguration(url: url)
        container = try ModelContainer(for: Bill.self, Category.self, configurations: configuration)
    } catch {
        fatalError("Failed to initialize database")
    }
    
    return Window()
        .modelContainer(container)
}
