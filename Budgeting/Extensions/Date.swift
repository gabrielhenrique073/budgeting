import Foundation

extension Date {
    
    var distance: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    static var quarter: Date? {
        return Calendar.current.date(byAdding: .month, value: 3, to: Date.now)
    }
    static func from(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
}
