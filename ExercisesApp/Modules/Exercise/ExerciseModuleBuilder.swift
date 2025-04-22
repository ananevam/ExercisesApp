import UIKit

class ExerciseModuleBuilder {
    static func build(_ exercise: ExerciseEntity) -> UIViewController {
        let view = ExerciseView()
        let interactor = ExerciseInteractor()
        // let router = ExerciseRouter()

        let presenter = ExercisePresenter(
            exercise: exercise,
            view: view,
            interactor: interactor,
            // router: router
        )

        view.output = presenter
        interactor.output = presenter
        // router.viewController = view

        return view
    }
}
