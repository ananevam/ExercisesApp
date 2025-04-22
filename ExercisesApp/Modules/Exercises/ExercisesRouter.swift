import UIKit

protocol ExercisesRouterInput {
    func navigateToExercise(_ exercise: ExerciseEntity)
}

class ExercisesRouter: ExercisesRouterInput {
    weak var viewController: UIViewController?

    func navigateToExercise(_ exercise: ExerciseEntity) {
        viewController?.navigationController?.pushViewController(
            ExerciseModuleBuilder.build(exercise),
            animated: true
        )
    }

    deinit {
        print("DEINIT ROUTER")
    }
}
