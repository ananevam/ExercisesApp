import Foundation

final class ExerciseManager {
    static let shared = ExerciseManager()

    private(set) lazy var exercises: [ExerciseEntity] = []
    private(set) var muscles: [MuscleEntity] = []

    private init() {
        loadMuscles()
        loadExercises()
    }
    private func loadMuscles() {
        guard let url = Bundle.main.url(forResource: "muscles", withExtension: "json") else {
            fatalError("File muscles.json not found")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            muscles = try decoder.decode([MuscleEntity].self, from: data)
        } catch {
            fatalError("Error loading exercises: \(error)")
        }
    }

    private func loadExercises() {
        guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json") else {
            fatalError("File exercises.json not found")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            exercises = try decoder.decode([ExerciseEntity].self, from: data)
        } catch {
            fatalError("Error loading exercises: \(error)")
        }
    }
}
