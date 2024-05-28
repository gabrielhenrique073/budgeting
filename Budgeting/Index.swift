import SwiftUI

@main
struct Index: App {
    
    @StateObject private var data = Data.shared
    
    var body: some Scene {
        WindowGroup {
            Window(context: data.container.viewContext)
                .environment(\.managedObjectContext, data.container.viewContext)
        }
    }
}

#Preview {
    
    @StateObject var data = Data.shared
    
    return Window(context: data.container.viewContext)
        .environment(\.managedObjectContext, data.container.viewContext)
}
