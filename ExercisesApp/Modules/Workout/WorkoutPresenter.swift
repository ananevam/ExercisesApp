import Foundation

protocol ExerciseSelectionDelegate: AnyObject {
    func didSelectExercise(_ exercise: ExerciseEntity)
}

class WorkoutPresenter {
    weak var view: WorkoutViewInput?
    var interactor: WorkoutInteractorInput
    var router: WorkoutRouterInput
    let workout: Workout

    init(
        workout: Workout,
        view: WorkoutViewInput,
        interactor: WorkoutInteractorInput,
        router: WorkoutRouterInput
    ) {
        self.workout = workout
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WorkoutPresenter: WorkoutInteractorOutput {
    func didAddExercise(_ item: Workout) {
        view?.showWorkout(item)
    }

    func didLoadWorkout(_ item: Workout) {
        view?.showWorkout(item)
    }
}

extension WorkoutPresenter: WorkoutViewOutput {
    func didTapDelete(_ item: WorkoutExercise) {
        interactor.deleteWorkoutExercise(item)
    }

    func didTapAddExercise() {
        router.navigateToMuscles(exerciseSelectionDelegate: self)
    }

    func didTapEdit(_ item: WorkoutExercise) {
        router.navigateToEdit(item)
    }

    func didSelectItem(_ item: Workout) {
        // router.navigateToItem(item)
    }

    func viewDidLoad() {
        interactor.loadWorkout(workout)
    }
}
extension WorkoutPresenter: ExerciseSelectionDelegate {
    func didSelectExercise(_ exercise: ExerciseEntity) {
        interactor.addExercise(to: workout, exercise: exercise)
    }
}
