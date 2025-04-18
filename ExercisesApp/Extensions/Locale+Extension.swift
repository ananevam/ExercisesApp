import Foundation

private let availableLangs = ["en", "ru"]

extension Locale {
    static var currentLanguageCode: String {
        let preferredLanguages = Locale.preferredLanguages

        for languageIdentifier in preferredLanguages {
            let languageCode = String(languageIdentifier.prefix(2))

            if availableLangs.contains(languageCode) {
                return languageCode
            }
        }

        return availableLangs.first!
    }
}
