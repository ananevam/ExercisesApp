import Foundation

protocol ExerciseInteractorInput {
    var output: ExerciseInteractorOutput? {get set}
    func loadExercise(_ exercise: ExerciseEntity)
}

protocol ExerciseInteractorOutput: AnyObject {
    func didLoadExercise(_ exercise: ExerciseEntity)
}

class ExerciseInteractor: ExerciseInteractorInput {
    weak var output: ExerciseInteractorOutput?
    func loadExercise(_ exercise: ExerciseEntity) {
        output?.didLoadExercise(exercise)
    }
}
