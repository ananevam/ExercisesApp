import Foundation

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
    func didLoadWorkout(_ item: Workout) {
        view?.showWorkout(item)
    }
}

extension WorkoutPresenter: WorkoutViewOutput {
    func didTapAddExercise() {
        router.navigateToMuscles()
    }

    func didSelectItem(_ item: Workout) {
        // router.navigateToItem(item)
    }

    func viewDidLoad() {
        interactor.loadWorkout(workout)
    }
}
