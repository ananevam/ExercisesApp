import Foundation

protocol ExerciseInteractorInput {
    var output: ExerciseInteractorOutput? {get set}
    func loadExercise(_ exercise: Exercise)
}

protocol ExerciseInteractorOutput: AnyObject {
    func didLoadExercise(_ exercise: Exercise)
}

class ExerciseInteractor: ExerciseInteractorInput {
    weak var output: ExerciseInteractorOutput?
    func loadExercise(_ exercise: Exercise) {
        output?.didLoadExercise(exercise)
    }
}
