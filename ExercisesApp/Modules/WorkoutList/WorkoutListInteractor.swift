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
        output?.didLoadItems(Workout.all)
    }
    func saveWorkout(name: String) {
        let item = Workout(name: name)
        item.save()
        loadItems()
    }
    func updateWorkout(_ item: Workout, name: String) {
        item.name = name
        item.save()
        loadItems()
    }
    func deleteWorkout(_ item: Workout) {
        item.delete()
        loadItems()
    }
}
