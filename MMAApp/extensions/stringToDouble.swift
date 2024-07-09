extension String {
    func heightStringToInches() -> Double? {
        let components = self.split(separator: "'")
        guard components.count == 2,
              let feet = Double(components[0].trimmingCharacters(in: .whitespaces)),
              let inches = Double(components[1].trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\"", with: "")) else {
            return nil
        }
        return (feet * 12) + inches
    }
}
