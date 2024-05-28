import SwiftUI
import CoreData

struct BillsView: View {
    
    private var context: NSManagedObjectContext
    
    @StateObject private var model: BillsModel
    
    @State private var isBillCreatorPresented = false
    @State private var billEditorItem: Bill?
    
    @FetchRequest(
        entity: Bill.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ]
    ) private var bills: FetchedResults<Bill>
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        _model = StateObject(
            wrappedValue: BillsModel(
                context: context
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Registered Bills"),
                    footer: Text("Manage the available bills creating and deleting them"),
                    content: {
                        ForEach(bills, id: \.self) { item in
//                            HStack {
//                                Text(item.category?.icon ?? "")
//                                VStack {
//                                    Text(item.category?.name ?? "")
//                                    Text(item.name ?? "")
//                                        .font(.caption)
//                                }
//                                Spacer()
//                                VStack {
//
//                                }
//                            }
                            Label (
                                title: {
                                    VStack (
                                        alignment: .leading,
                                        content: {
                                            Text(item.category?.name ?? "")
                                            Text(item.name ?? "")
                                                .font(.caption)
                                        }
                                    )
                                    Spacer()
                                    VStack (
                                        alignment: .center,
                                        content: {
                                            Text(item.amount.toCurrency)
                                            Text(item.nextDueAt?.distance.toString ?? "")
                                                .font(.caption)
                                        }
                                    )
                                },
                                icon: {
                                    Text(item.category?.icon ?? "")
                                }
                            )
                            .labelStyle(CustomLabelStyle())
                            .swipeActions(edge: .leading) {
                                Button(
                                    action: {
                                        billEditorItem = item
                                    },
                                    label: {
                                        Image(systemName: "pencil")
                                    }
                                )
                                .tint(.orange)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(
                                    action: {
                                        model.delete(item: item)
                                    },
                                    label: {
                                        Image(systemName: "trash")
                                    }
                                )
                                .tint(.red)
                            }
                        }
                    }
                )
            }
            
            .toolbar {
                ToolbarItem (
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: {
                                isBillCreatorPresented.toggle()
                            },
                            label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        )
                    }
                )
            }
            
            .sheet(
                isPresented: $isBillCreatorPresented,
                content: {
                    BillCreatorView(context: context)
                }
            )
            .sheet(
                item: $billEditorItem,
                content: { item in
                    BillEditorView(context: context, item: item)
                }
            )
            
            .navigationTitle("Bills")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
