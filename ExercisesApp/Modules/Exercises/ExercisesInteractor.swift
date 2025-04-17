import Foundation

protocol ExercisesInteractorInput {
    var output: ExercisesInteractorOutput? {get set}
    func loadExercises(muscle: MuscleEntity?)
}

protocol ExercisesInteractorOutput: AnyObject {
    func didLoadExercises(_ exercises: [Exercise])
}

class ExercisesInteractor: ExercisesInteractorInput {
    weak var output: ExercisesInteractorOutput?
    func loadExercises(muscle: MuscleEntity?) {
        let allExercises = ExerciseManager.shared.exercises

        let filteredExercises: [Exercise]
        if let muscle = muscle {
            filteredExercises = allExercises.filter { exercise in
                exercise.primaryMuscles.contains(muscle.name) ||
                exercise.secondaryMuscles.contains(muscle.name)
            }
        } else {
            filteredExercises = allExercises
        }
        output?.didLoadExercises(filteredExercises)
    }
}
