import UIKit

protocol WorkoutRouterInput {
    func navigateToItem(_ item: Workout)
}

class WorkoutRouter: WorkoutRouterInput {
    weak var viewController: UIViewController?

    func navigateToItem(_ item: Workout) {
        // viewController?.navigationController?.pushViewController(
        //     ItemModuleBuilder.build(item),
        //     animated: true
        // )
    }
}
