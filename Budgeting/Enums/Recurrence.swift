enum Recurrence: Int32 {
    case determined = 0
    case indeterminate = 1
    
    var label: String {
        switch self {
        case .determined:
            return "Determined"
        case .indeterminate:
            return "Indeterminate"
        }
    }
}
