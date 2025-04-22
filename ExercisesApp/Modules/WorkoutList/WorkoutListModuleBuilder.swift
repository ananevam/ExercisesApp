import UIKit

class WorkoutListModuleBuilder {
    static func build() -> UIViewController {
        let view = WorkoutListView()
        let interactor = WorkoutListInteractor()
        let router = WorkoutListRouter()

        let presenter = WorkoutListPresenter(
            view: view,
            interactor: interactor,
            router: router
        )

        view.output = presenter
        interactor.output = presenter
        router.viewController = view

        return view
    }
}
