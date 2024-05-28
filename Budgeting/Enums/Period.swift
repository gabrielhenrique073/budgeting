enum Period: Int {
    case day = 0
    case week = 1
    case month = 2
    case year = 3
    
    var plural: String {
        switch self {
        case .day:
            return "Days"
        case .week:
            return "Weeks"
        case .month:
            return "Months"
        case .year:
            return "Years"
        }
    }
    var singular: String {
        switch self {
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .year:
            return "Year"
        }
    }
}
