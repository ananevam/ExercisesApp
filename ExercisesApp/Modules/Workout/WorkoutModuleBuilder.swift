import UIKit

class WorkoutModuleBuilder {
    static func build(_ workout: Workout) -> UIViewController {
        let view = WorkoutView()
        let interactor = WorkoutInteractor()
        let router = WorkoutRouter()

        let presenter = WorkoutPresenter(
            workout: workout,
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
