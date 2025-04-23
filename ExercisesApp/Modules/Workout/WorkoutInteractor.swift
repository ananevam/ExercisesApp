import Foundation

protocol WorkoutInteractorInput {
    var output: WorkoutInteractorOutput? {get set}
    func loadWorkout(_ item: Workout)
}

protocol WorkoutInteractorOutput: AnyObject {
    func didLoadWorkout(_ item: Workout)
}

class WorkoutInteractor: WorkoutInteractorInput {
    weak var output: WorkoutInteractorOutput?

    func loadWorkout(_ item: Workout) {
        output?.didLoadWorkout(item)
    }
}
