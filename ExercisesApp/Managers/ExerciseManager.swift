import Foundation

final class ExerciseManager {
    static let shared = ExerciseManager()

    private(set) lazy var exercises: [Exercise] = {
        loadExercises()
        return exercises
    }()
    // "beginner", "intermediate", "expert"
    private(set) var levels: [String] = []
    // "isolation", "compound"
    private(set) var mechanics: Set<String> = []
    // "olympic weightlifting", "cardio", "powerlifting", "strength", "strongman", "stretching", "plyometrics"
    private(set) var categories: Set<String> = []

    private init() {}

    private func loadExercises() {
        guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json") else {
            fatalError("File exercises.json not found")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            exercises = try decoder.decode([Exercise].self, from: data)
            extractUniqueAttributes()
        } catch {
            fatalError("Error loading exercises: \(error)")
        }
    }
    private func extractUniqueAttributes() {
        let preferredOrder = ["beginner", "intermediate", "expert"]

        // Получаем уникальные значения levels
        let uniqueLevels = Set(exercises.map { $0.level })

        // Сначала добавляем элементы из preferredOrder, если они есть в uniqueLevels
        var sortedLevels = preferredOrder.filter { uniqueLevels.contains($0) }

        // Потом добавляем оставшиеся элементы, которых нет в preferredOrder
        let remainingLevels = uniqueLevels.subtracting(Set(preferredOrder))
        sortedLevels.append(contentsOf: remainingLevels)

        levels = sortedLevels

        mechanics = Set(exercises.compactMap { $0.mechanic })
        categories = Set(exercises.map { $0.category })
    }
}
