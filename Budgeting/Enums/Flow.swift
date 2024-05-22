enum Flow: Int, Codable {
    case income = 0
    case expense = 1
    
    var description: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        }
    }
}
