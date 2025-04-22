import Foundation

protocol WorkoutListInteractorInput {
    var output: WorkoutListInteractorOutput? {get set}
    func loadItems()
    func saveWorkout(name: String)
}

protocol WorkoutListInteractorOutput: AnyObject {
  func didLoadItems(_ items: [Workout])
}

class WorkoutListInteractor: WorkoutListInteractorInput {
    weak var output: WorkoutListInteractorOutput?

    func loadItems() {
        output?.didLoadItems(CoreDataManager.shared.loadWorkouts())
    }
    func saveWorkout(name: String) {
        if let newItem = CoreDataManager.shared.saveWorkout(name: name) {
            loadItems()
        }
    }
}
