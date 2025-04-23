import Foundation

class ExercisesPresenter {
    weak var view: ExercisesViewInput?
    var interactor: ExercisesInteractorInput
    var router: ExercisesRouterInput
    private var allExercises: [ExerciseEntity] = []
    private let mucle: MuscleEntity?
    private let exerciseSelectionDelegate: ExerciseSelectionDelegate?
    init(
        mucle: MuscleEntity?,
        view: ExercisesViewInput,
        interactor: ExercisesInteractorInput,
        router: ExercisesRouterInput,
        exerciseSelectionDelegate: ExerciseSelectionDelegate?
    ) {
        self.mucle = mucle
        self.view = view
        self.interactor = interactor
        self.router = router
        self.exerciseSelectionDelegate = exerciseSelectionDelegate
    }
}

extension ExercisesPresenter: ExercisesInteractorOutput {
    func didLoadExercises(_ exercises: [ExerciseEntity]) {
        allExercises = exercises
        view?.showExercises(exercises)
    }
}

extension ExercisesPresenter: ExercisesViewOutput {
    func didSelectExercise(_ exercise: ExerciseEntity) {
        if let exerciseSelectionDelegate = exerciseSelectionDelegate {
            exerciseSelectionDelegate.didSelectExercise(exercise)
            router.backTwice()
        } else {
            router.navigateToExercise(exercise)
        }
    }

    func viewDidLoad() {
        interactor.loadExercises(muscle: mucle)
    }

    func searchTextChanged(_ text: String?) {
        guard let searchText = text else {
            return
        }
        guard !searchText.isEmpty else {
            view?.showExercises(allExercises)
            return
        }

        let filtered = allExercises.filter { exercise in
            exercise.name.localized.lowercased().contains(searchText.lowercased())
        }

        view?.showExercises(filtered)
    }
}
