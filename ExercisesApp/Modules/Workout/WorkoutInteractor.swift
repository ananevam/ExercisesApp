import Foundation

protocol WorkoutInteractorInput {
    var output: WorkoutInteractorOutput? {get set}
    func loadWorkout(_ item: Workout)
    func addExercise(to workout: Workout, exercise: ExerciseEntity)
    func deleteWorkoutExercise(_ item: WorkoutExercise)
}

protocol WorkoutInteractorOutput: AnyObject {
    func didLoadWorkout(_ item: Workout)
    func didAddExercise(_ item: Workout)
}

class WorkoutInteractor: WorkoutInteractorInput {
    func deleteWorkoutExercise(_ item: WorkoutExercise) {
        let workout = item.workout
        workout.exercises?.remove(item)
        item.delete()
        output?.didLoadWorkout(workout)
    }

    func addExercise(to workout: Workout, exercise: ExerciseEntity) {
        let workoutExercise = WorkoutExercise(exerciseId: exercise.id, workout: workout)
        workoutExercise.save()
        output?.didAddExercise(workout)
    }

    weak var output: WorkoutInteractorOutput?

    func loadWorkout(_ item: Workout) {
        output?.didLoadWorkout(item)
    }
}
