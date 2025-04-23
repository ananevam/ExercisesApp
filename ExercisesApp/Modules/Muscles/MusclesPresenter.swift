import Foundation

class MusclesPresenter {
    weak var view: MusclesViewInput?
    var interactor: MusclesInteractorInput
    var router: MusclesRouterInput
    var exerciseSelectionDelegate: ExerciseSelectionDelegate?

    init(
        view: MusclesViewInput,
        interactor: MusclesInteractorInput,
        router: MusclesRouterInput,
        exerciseSelectionDelegate: ExerciseSelectionDelegate?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.exerciseSelectionDelegate = exerciseSelectionDelegate
    }
}

extension MusclesPresenter: MusclesInteractorOutput {
    func didLoadItems(_ items: [MuscleEntity]) {
        view?.showItems(items)
    }
}

extension MusclesPresenter: MusclesViewOutput {
    func didSelectItem(_ item: MuscleEntity) {
        router.navigateToItem(item, exerciseSelectionDelegate: exerciseSelectionDelegate)
    }

    func viewDidLoad() {
        interactor.loadItems()
    }
}
