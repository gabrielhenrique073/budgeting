import SwiftUI
import CoreData

struct BillCreatorView: View {
    
    enum FocusableFields: Hashable {
        case name
        case amount
    }
    
    private var context: NSManagedObjectContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var model: BillCreatorModel
    
    @FocusState private var focusedField: FocusableFields?
    
    @State private var name = ""
    @State private var category = 0
    @State private var amount = ""
    @State private var interval = 1
    @State private var period = Period.month.rawValue
    @State private var isEndless = true
    @State private var nextDueAt = Date.now
    
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ]
    ) private var categories: FetchedResults<Category>
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        _model = State(
            initialValue: BillCreatorModel(
                context: context
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(
                    header: Text("Basic Information"),
                    content: {
                        TextField("Name", text: $name)
                            .focused($focusedField, equals: .name)
                        TextField("Amount", text: $amount)
                            .focused($focusedField, equals: .amount)
                        Picker("Category", selection: $category) {
                            ForEach(categories.indices, id: \.self) { index in
                                Label (
                                    title: {
                                        Text(categories[index].name ?? "")
                                    },
                                    icon: {
                                        Text(categories[index].icon ?? "")
                                    }
                                )
                                .tag(index)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                )
                
                Section(
                    footer: Text("Toggle this if this bill have no end date, for example: car insurance, you have to pay indefinitely until you choose to cancel it"),
                    content: {
                        Toggle(
                            isOn: $isEndless,
                            label: {
                                Text("Endless payments")
                            }
                        )
                    }
                )
                
                Section(
                    footer: Text("Select when is going to be the next date that you will have to pay this bill"),
                    content: {
                        DatePicker(
                            selection: $nextDueAt,
                            in: Date.now...,
                            displayedComponents: .date,
                            label: {
                                Text("Next Due Date")
                            }
                        )
                    }
                )
                
                Section(
                    footer: Text("Set how often you have to pay this bill, for example: every 2 weeks, every month, every year and so on"),
                    content: {
                        VStack (
                            alignment: .center,
                            content: {
                                Stepper(value: $interval, in: 1...365, step: 1) {
                                    HStack {
                                        Text("Pay every")
                                        Text(interval.toString)
                                            .foregroundColor(.secondary)
                                        
                                        if interval > 1 {
                                            Text(Period(rawValue: period)?.plural.lowercased() ?? "")
                                        }
                                        else {
                                            Text(Period(rawValue: period)?.singular.lowercased() ?? "")
                                        }
                                    }
                                }
                                .disabled(!isEndless)
                                
                                Picker("How often", selection: $period) {
                                    Text(Period.day.singular).tag(Period.day.rawValue)
                                    Text(Period.week.singular).tag(Period.week.rawValue)
                                    Text(Period.month.singular).tag(Period.month.rawValue)
                                    Text(Period.year.singular).tag(Period.year.rawValue)
                                }
                                .pickerStyle(.segmented)
                                .disabled(!isEndless)
                            }
                        )
                    }
                )
            }
            
            .onAppear {
                focusedField = .name
            }
            
            .toolbar {
                ToolbarItem (
                    placement: .topBarLeading,
                    content: {
                        Button(
                            action: onCancel,
                            label: {
                                Text("Cancel")
                            }
                        )
                    }
                )
                ToolbarItem (
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: onDone,
                            label: {
                                Text("Done")
                            }
                        )
                        .disabled(name.isEmpty || amount.isEmpty)
                    }
                )
            }
            
            .navigationTitle("New Bill")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func onCancel() {
        dismiss()
    }
    func onDone() {
        model.create(
            name: name,
            amount: amount.toFloat ?? 0,
            category: categories[category],
            isEndless: isEndless,
            nextDueAt: nextDueAt,
            interval: interval,
            period: Period(rawValue: period) ?? .day
        )
        
        dismiss()
    }
}
