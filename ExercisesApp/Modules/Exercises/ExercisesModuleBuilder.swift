import UIKit

class ExercisesModuleBuilder {
    static func build() -> UIViewController {
        let view = ExercisesView()
        let interactor = ExercisesInteractor()
        let router = ExercisesRouter()

        let presenter = ExercisesPresenter(
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
