import Foundation

protocol ExercisesInteractorInput {
    var output: ExercisesInteractorOutput? {get set}
    func loadExercises(muscle: MuscleEntity?)
}

protocol ExercisesInteractorOutput: AnyObject {
    func didLoadExercises(_ exercises: [ExerciseEntity])
}

class ExercisesInteractor: ExercisesInteractorInput {
    weak var output: ExercisesInteractorOutput?
    func loadExercises(muscle: MuscleEntity?) {
        let allExercises = ExerciseManager.shared.exercises

        let filteredExercises: [ExerciseEntity]
        if let muscle = muscle {
            filteredExercises = allExercises.filter { exercise in
                exercise.primaryMuscles.contains(muscle.id)
            }
        } else {
            filteredExercises = allExercises
        }
        output?.didLoadExercises(filteredExercises)
    }
}
