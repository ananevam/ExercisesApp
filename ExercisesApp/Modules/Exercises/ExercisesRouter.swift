import UIKit

protocol ExercisesRouterInput {
    func navigateToExercise(_ exercise: Exercise)
}

class ExercisesRouter: ExercisesRouterInput {
    weak var viewController: UIViewController?

    func navigateToExercise(_ exercise: Exercise) {
        viewController?.navigationController?.pushViewController(
            ExerciseModuleBuilder.build(exercise),
            animated: true
        )
    }

    deinit {
        print("DEINIT ROUTER")
    }
}
