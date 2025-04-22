import Foundation

class WorkoutListPresenter {
    weak var view: WorkoutListViewInput?
    var interactor: WorkoutListInteractorInput
    var router: WorkoutListRouterInput

    init(
        view: WorkoutListViewInput,
        interactor: WorkoutListInteractorInput,
        router: WorkoutListRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WorkoutListPresenter: WorkoutListInteractorOutput {
    func didLoadItems(_ items: [Workout]) {
        view?.showItems(items)
    }
}

extension WorkoutListPresenter: WorkoutListViewOutput {
    func didSelectItem(_ item: Workout) {
        router.navigateToItem(item)
    }

    func viewDidLoad() {
        interactor.loadItems()
    }
    func didTapAddWorkout() {
        router.presentAddWorkoutAlert { [weak self] name in
            self?.didEnterWorkoutName(name)
        }
    }

    func didEnterWorkoutName(_ name: String) {
        interactor.saveWorkout(name: name)
    }
}
