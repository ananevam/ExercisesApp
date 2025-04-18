import Foundation
import UIKit

struct MuscleEntity: Decodable {
    let id: String
    let name: LocalizedValue<[String: String]>
    let description: LocalizedValue<[String: String]>
    let image: String?
    var uiImage: UIImage? {
        guard let image = image else {
            return nil
        }
        return UIImage(named: image)
    }
}
