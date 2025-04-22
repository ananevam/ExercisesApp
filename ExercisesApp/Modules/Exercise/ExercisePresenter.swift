import Foundation

class ExercisePresenter {
    private let exercise: ExerciseEntity

    weak var view: ExerciseViewInput?
    var interactor: ExerciseInteractorInput
    // var router: HeroesRouterInput

    init(
        exercise: ExerciseEntity,
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
    func didLoadExercise(_ exercise: ExerciseEntity) {
        view?.showExercise(exercise)
    }
}

extension ExercisePresenter: ExerciseViewOutput {
    func viewDidLoad() {
        interactor.loadExercise(exercise)
    }
}
