import Foundation

class ExercisePresenter {
    private let exercise: Exercise

    weak var view: ExerciseViewInput?
    var interactor: ExerciseInteractorInput
    // var router: HeroesRouterInput

    init(
        exercise: Exercise,
        view: ExerciseViewInput,
        interactor: ExerciseInteractorInput
        // router: HeroesRouterInput
    ) {
        self.exercise = exercise
        self.view = view
        self.interactor = interactor
        // self.router = router
    }

    deinit {
        print("DEINIT PRESENTER")
    }
}

extension ExercisePresenter: ExerciseInteractorOutput {
    func didLoadExercise(_ exercise: Exercise) {
        view?.showExercise(exercise)
    }
}

extension ExercisePresenter: ExerciseViewOutput {
    func viewDidLoad() {
        interactor.loadExercise(exercise)
    }
}
