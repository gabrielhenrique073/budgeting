enum Flow: Int32 {
    case income = 0
    case expense = 1
    
    var label: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        }
    }
}
