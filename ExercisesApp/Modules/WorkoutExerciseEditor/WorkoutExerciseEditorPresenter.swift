import Foundation

class WorkoutExerciseEditorPresenter {
    weak var view: WorkoutExerciseEditorViewInput?
    var interactor: WorkoutExerciseEditorInteractorInput
    var router: WorkoutExerciseEditorRouterInput
    let workoutExercise: WorkoutExercise

    init(
        workoutExercise: WorkoutExercise,
        view: WorkoutExerciseEditorViewInput,
        interactor: WorkoutExerciseEditorInteractorInput,
        router: WorkoutExerciseEditorRouterInput
    ) {
        self.workoutExercise = workoutExercise
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WorkoutExerciseEditorPresenter: WorkoutExerciseEditorInteractorOutput {
}

extension WorkoutExerciseEditorPresenter: WorkoutExerciseEditorViewOutput {
    func viewDidLoad() {
        view?.showItem(workoutExercise)
    }
}
