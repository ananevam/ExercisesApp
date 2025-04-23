import UIKit

protocol WorkoutRouterInput {
    func navigateToItem(_ item: Workout)
    func navigateToMuscles(exerciseSelectionDelegate: ExerciseSelectionDelegate?)
}

class WorkoutRouter: WorkoutRouterInput {
    weak var viewController: UIViewController?

    func navigateToItem(_ item: Workout) {
        // viewController?.navigationController?.pushViewController(
        //     ItemModuleBuilder.build(item),
        //     animated: true
        // )
    }
    func navigateToMuscles(exerciseSelectionDelegate: ExerciseSelectionDelegate?) {
        viewController?.navigationController?.pushViewController(
            MusclesModuleBuilder.build(exerciseSelectionDelegate: exerciseSelectionDelegate),
            animated: true
        )
    }
}
