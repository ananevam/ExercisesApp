import Foundation

struct LocalizedValue<WrappedValue: Decodable & Hashable>: Decodable, Hashable {
    let wrappedValue: WrappedValue
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(WrappedValue.self)
    }
}
extension LocalizedValue where WrappedValue == [String: String] {
    var localized: String {
        return self.wrappedValue[Locale.currentLanguageCode] ?? self.wrappedValue.first?.value ?? ""
    }
}
extension LocalizedValue where WrappedValue == [String: [String]] {
    var localized: [String] {
        return self.wrappedValue[Locale.currentLanguageCode] ?? self.wrappedValue.first?.value ?? []
    }
}
