import Foundation

protocol WorkoutListInteractorInput {
    var output: WorkoutListInteractorOutput? {get set}
    func loadItems()
    func saveWorkout(name: String)
    func updateWorkout(_ item: Workout, name: String)
    func deleteWorkout(_ item: Workout)
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
        if CoreDataManager.shared.saveWorkout(name: name) != nil {
            loadItems()
        }
    }
    func updateWorkout(_ item: Workout, name: String) {
        item.name = name
        CoreDataManager.shared.saveContext()
        loadItems()
    }
    func deleteWorkout(_ item: Workout) {
        CoreDataManager.shared.deleteWorkout(item)
        loadItems()
    }
}
