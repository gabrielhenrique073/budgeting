import SwiftUI
import SwiftData
import Foundation

struct Window: View {
    var body: some View {
        TabView {
            Monitor()
            .tabItem {
                Label("Monitor", systemImage: "light.beacon.min.fill")
            }
            
            BillsList()
            .tabItem {
                Label("Bills", systemImage: "dollarsign")
            }
            
            Settings()
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}
