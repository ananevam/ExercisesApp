import Foundation

protocol ExercisesInteractorInput {
    var output: ExercisesInteractorOutput? {get set}
    func loadExercises()
}

protocol ExercisesInteractorOutput: AnyObject {
    func didLoadExercises(_ exercises: [Exercise])
}

class ExercisesInteractor: ExercisesInteractorInput {
    weak var output: ExercisesInteractorOutput?
    func loadExercises() {
        output?.didLoadExercises(ExerciseManager.shared.exercises)
    }
}
