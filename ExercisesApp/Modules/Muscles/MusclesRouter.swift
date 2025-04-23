import UIKit

protocol MusclesRouterInput {
    func navigateToItem(_ item: MuscleEntity, exerciseSelectionDelegate: ExerciseSelectionDelegate?)
}

class MusclesRouter: MusclesRouterInput {
    weak var viewController: UIViewController?

    func navigateToItem(_ item: MuscleEntity, exerciseSelectionDelegate: ExerciseSelectionDelegate?) {
        viewController?.navigationController?.pushViewController(
            ExercisesModuleBuilder.build(muscle: item, exerciseSelectionDelegate: exerciseSelectionDelegate),
            animated: true
        )
    }
}
