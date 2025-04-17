import Foundation

class ExercisesPresenter {
    weak var view: ExercisesViewInput?
    var interactor: ExercisesInteractorInput
    var router: ExercisesRouterInput
    private var allExercises: [Exercise] = []
    private let mucle: MuscleEntity?
    init(
        mucle: MuscleEntity?,
        view: ExercisesViewInput,
        interactor: ExercisesInteractorInput,
        router: ExercisesRouterInput
    ) {
        self.mucle = mucle
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ExercisesPresenter: ExercisesInteractorOutput {
    func didLoadExercises(_ exercises: [Exercise]) {
        allExercises = exercises
        view?.showExercises(exercises)
    }
}

extension ExercisesPresenter: ExercisesViewOutput {
    func didSelectExercise(_ exercise: Exercise) {
        router.navigateToExercise(exercise)
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
            exercise.name.lowercased().contains(searchText.lowercased()) ||
            exercise.level.lowercased().contains(searchText.lowercased()) ||
            exercise.category.lowercased().contains(searchText.lowercased())
        }

        view?.showExercises(filtered)
    }
}
