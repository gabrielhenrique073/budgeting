import Foundation
extension Float {
    var toString: String {
        return String(self)
    }
    var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        return formatter.string(from: self as NSNumber) ?? self.toString
    }
}
