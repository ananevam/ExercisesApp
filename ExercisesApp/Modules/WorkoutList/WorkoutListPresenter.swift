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
    func didTapDelete(_ item: Workout) {
        router.showDeleteConfirmation(item) { [weak self] in
            self?.didConfirmDeleteWorkout(item)
        }
    }

    func didTapEdit(_ item: Workout) {
        router.presentEditWorkoutAlert(item) { [weak self] name in
            self?.didUpdateWorkoutName(item, name: name)
        }
    }

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

    func didUpdateWorkoutName(_ item: Workout, name: String) {
        interactor.updateWorkout(item, name: name)
    }
    func didConfirmDeleteWorkout(_ item: Workout) {
        interactor.deleteWorkout(item)
    }
}
