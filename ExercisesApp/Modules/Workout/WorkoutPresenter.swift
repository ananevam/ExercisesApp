import Foundation

class WorkoutPresenter {
    weak var view: WorkoutViewInput?
    var interactor: WorkoutInteractorInput
    var router: WorkoutRouterInput

    init(
        view: WorkoutViewInput,
        interactor: WorkoutInteractorInput,
        router: WorkoutRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WorkoutPresenter: WorkoutInteractorOutput {
    func didLoadItems(_ items: [Workout]) {
        view?.showItems(items)
    }
}

extension WorkoutPresenter: WorkoutViewOutput {
    func didSelectItem(_ item: Workout) {
        router.navigateToItem(item)
    }

    func viewDidLoad() {
        interactor.loadItems()
    }
}
