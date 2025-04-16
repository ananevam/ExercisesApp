import Foundation

struct Exercise: Codable {
    let id: String
    let name: String
    let force: String?
    let level: String
    let mechanic: String?
    let equipment: String?
    let primaryMuscles: [String]
    let secondaryMuscles: [String]
    let instructions: [String]
    let category: String
    let images: [String]

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
