import Foundation

protocol WorkoutInteractorInput {
    var output: WorkoutInteractorOutput? {get set}
    func loadItems()
}

protocol WorkoutInteractorOutput: AnyObject {
  func didLoadItems(_ items: [Workout])
}

class WorkoutInteractor: WorkoutInteractorInput {
    weak var output: WorkoutInteractorOutput?

    func loadItems() {
        // output?.didLoadItems(...)
    }
}
