import UIKit

class ExercisesModuleBuilder {
    static func build(muscle: MuscleEntity?) -> UIViewController {
        let view = ExercisesView()
        let interactor = ExercisesInteractor()
        let router = ExercisesRouter()

        let presenter = ExercisesPresenter(
            mucle: muscle,
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
