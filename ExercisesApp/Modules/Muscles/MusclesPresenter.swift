import Foundation

class MusclesPresenter {
    weak var view: MusclesViewInput?
    var interactor: MusclesInteractorInput
    var router: MusclesRouterInput

    init(
        view: MusclesViewInput,
        interactor: MusclesInteractorInput,
        router: MusclesRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MusclesPresenter: MusclesInteractorOutput {
    func didLoadItems(_ items: [MuscleEntity]) {
        view?.showItems(items)
    }
}

extension MusclesPresenter: MusclesViewOutput {
    func didSelectItem(_ item: MuscleEntity) {
        router.navigateToItem(item)
    }

    func viewDidLoad() {
        interactor.loadItems()
    }
}
