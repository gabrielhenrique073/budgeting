enum Frequency: Int32 {
    case daily = 0
    case weekly = 1
    case monthly = 2
    case quarterly = 3
    case annually = 4
    
    var label: String {
        switch self {
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case .quarterly:
            return "Quarterly"
        case .annually:
            return "Annually"
        }
    }
}
