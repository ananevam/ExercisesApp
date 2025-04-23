import UIKit

class ExercisesModuleBuilder {
    static func build(
        muscle: MuscleEntity?,
        exerciseSelectionDelegate: ExerciseSelectionDelegate?
    ) -> UIViewController {
        let view = ExercisesView()
        let interactor = ExercisesInteractor()
        let router = ExercisesRouter()

        let presenter = ExercisesPresenter(
            mucle: muscle,
            view: view,
            interactor: interactor,
            router: router,
            exerciseSelectionDelegate: exerciseSelectionDelegate
        )

        view.output = presenter
        interactor.output = presenter
        router.viewController = view

        return view
    }
}
