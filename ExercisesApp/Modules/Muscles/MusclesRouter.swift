import UIKit

protocol MusclesRouterInput {
    func navigateToItem(_ item: MuscleEntity)
}

class MusclesRouter: MusclesRouterInput {
    weak var viewController: UIViewController?

    func navigateToItem(_ item: MuscleEntity) {
        viewController?.navigationController?.pushViewController(
            ExercisesModuleBuilder.build(muscle: item),
            animated: true
        )
    }
}
