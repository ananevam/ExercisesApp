import UIKit

class WorkoutModuleBuilder {
    static func build() -> UIViewController {
        let view = WorkoutView()
        let interactor = WorkoutInteractor()
        let router = WorkoutRouter()

        let presenter = WorkoutPresenter(
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
