import SwiftUI
import Foundation
import CoreData

struct BillsListItem: View {
    
    var item: Bill
    
    var body: some View {
        Label (
            title: {
                HStack (alignment: .center) {
                    VStack (
                        alignment: .leading,
                        content: {
                            Text(item.category?.name ?? "as")
                            Text(item.title ?? "")
                                .font(.caption)
                        }
                    )
                    Spacer()
                    VStack (
                        alignment: .trailing,
                        content: {
                            Text(item.amount.toCurrency)
                                .foregroundColor(item.flow == Flow.expense.rawValue ? .red : .green)
                            Text(item.date?.distance.toString ?? "")
                                .font(.caption)
                        }
                    )
                }
            },
            icon: {
                Text(item.category?.icon ?? "")
            }
        )
    }
}
