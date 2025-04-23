import Foundation

struct ExerciseEntity: Decodable {
    let id: String
    let name: LocalizedValue<[String: String]>
    let description: LocalizedValue<[String: String]>
    let primaryMuscles: [String]
    let secondaryMuscles: [String]
    let instructions: LocalizedValue<[String: [String]]>
    let images: [String]

    lazy var muscles = {
        return ExerciseManager.shared.muscles.filter { primaryMuscles.contains($0.id) }
    }()

    var imageUrl: URL? {
        let img = images.first
        if let img = img {
            let urlString = "https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/\(img)"
            return URL(string: urlString)
        }
        return nil
    }
    var imageUrls: [URL] {
        images.compactMap {
            URL(string: "https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/\($0)")
        }
    }
}
