extension String {
    var toFloat: Float? {
        return Float(self)
    }
    var toCurrency: String? {
        return self.toFloat?.toCurrency
    }
}
