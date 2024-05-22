enum Recurrence: Int, Codable {
    case determined = 0
    case indeterminate = 1
    
    var description: String {
        switch self {
        case .determined:
            return "Determined"
        case .indeterminate:
            return "Indeterminate"
        }
    }
}
