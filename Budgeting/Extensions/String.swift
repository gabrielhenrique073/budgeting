extension String {
    var toFloat: Float {
        return Float(self) ?? 0.0
    }
    var toCurrency: String {
        return self.toFloat.toCurrency
    }
}
