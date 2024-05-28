//import SwiftUI
//import Foundation
//import CoreData
//
//struct BillsList: View {
//    
//    @Environment(\.managedObjectContext) private var managedObjectContext
//    @FetchRequest(sortDescriptors: []) private var bills: FetchedResults<Bill>
//    
//    var body: some View {
//        ForEach(bills) { item in
//            BillsListItem(item: item)
//                .swipeActions {
//                    
//                    // Delete
//                    Button(
//                        action: {
//                            onDelete(item: item)
//                        },
//                        label: {
//                            Text("Delete")
//                        }
//                    )
//                    .tint(.red)
//                    
//                    // Edit
//                    Button(
//                        action: {
//                            onEdit(item: item)
//                        },
//                        label: {
//                            Text("Edit")
//                        }
//                    )
//                    .tint(.orange)
//                }
//        }
//    }
//    
//    func onDelete(item: Bill) {
//        managedObjectContext.delete(item)
//
//        do {
//            try managedObjectContext.save()
//        } catch {
//            fatalError("Failed to delete bill")
//        }
//    }
//    func onEdit(item: Bill) {
//        
//    }
//}
//    
//    
//    
//    
//
////import SwiftUI
////import SwiftData
////import Foundation
////
////struct BillsList: View {
////    
////    var bills: [Bill] {
////        
////        let from: Date = Date.now
////        let to: Date = Date.quarter!
////        
////        
//////        do {
//////            let descriptor = FetchDescriptor<Bill>(sortBy: [SortDescriptor(\.title)])
//////            let rows = try modelContext.fetch(descriptor)
//////            
//////            var ret: [Bill] = []
//////            
//////            for bill in rows {
//////                if bill.recurrence == .indeterminate {
//////                    var current = bill.date
//////                    
//////                    while current <= to {
//////                        
//////                        if current >= from {
//////                            let copy = Bill(title: bill.title, category: bill.category, flow: bill.flow, interval: bill.interval, frequency: bill.frequency, recurrence: bill.recurrence, amount: bill.amount, date: bill.date)
//////                            copy.date = current
//////                            ret.append(copy)
//////                            
//////                        }
//////                        
//////                        switch bill.frequency {
//////                        case .annually:
//////                            current = Calendar.current.date(byAdding: .year, value: 1 * bill.interval, to: current)!
//////                        case .quarterly:
//////                            current = Calendar.current.date(byAdding: .month, value: 3 * bill.interval, to: current)!
//////                        case .monthly:
//////                            current = Calendar.current.date(byAdding: .month, value: 1 * bill.interval, to: current)!
//////                        case .weekly:
//////                            current = Calendar.current.date(byAdding: .day, value: 7 * bill.interval, to: current)!
//////                        default:
//////                            current = Calendar.current.date(byAdding: .day, value: 1 * bill.interval, to: current)!
//////                        }
//////                    }
//////                }
//////            }
////            
////            return []
//////        } catch {
//////            fatalError("Failed to fetch bills")
//////        }
////    }
////    
////    var body: some View {
////        ForEach(bills) { item in
//////            Label (
//////                title: {
//////                    HStack (alignment: .center) {
//////                        VStack (
//////                            alignment: .leading,
//////                            content: {
//////                                Text(item.category.name)
//////                                Text(item.title)
//////                                    .font(.caption)
//////                            }
//////                        )
//////                        Spacer()
//////                        VStack (
//////                            alignment: .trailing,
//////                            content: {
//////                                Text(String(item.amount.toCurrency))
//////                                    .foregroundColor(item.flow == .expense ? .red : .green)
//////                                Text(item.date.distance.toString)
//////                                    .font(.caption)
//////                            }
//////                        )
//////                    }
//////                },
//////                icon: {
//////                    Text(item.category.icon)
//////                }
//////            )
//////            .swipeActions {
//////                Button(
//////                    action: {
//////                        modelContext.delete(item)
//////                    },
//////                    label: {
//////                        Text("Delete")
//////                    }
//////                )
//////                .tint(.red)
//////                
//////                // Edit Button
//////                Button(
//////                    action: {
//////                        
//////                    },
//////                    label: {
//////                        Text("Edit")
//////                    }
//////                )
//////                .tint(.orange)
//////            }
////        }
////    }
////}
//
