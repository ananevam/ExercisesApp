import Foundation

protocol MusclesInteractorInput {
    var output: MusclesInteractorOutput? {get set}
    func loadItems()
}

protocol MusclesInteractorOutput: AnyObject {
  func didLoadItems(_ items: [MuscleEntity])
}

class MusclesInteractor: MusclesInteractorInput {
    weak var output: MusclesInteractorOutput?

    func loadItems() {
        output?.didLoadItems(ExerciseManager.shared.muscles)
    }
}
