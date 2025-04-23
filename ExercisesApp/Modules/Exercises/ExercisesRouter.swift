import UIKit

protocol ExercisesRouterInput {
    func navigateToExercise(_ exercise: ExerciseEntity)
    func backTwice()
}

class ExercisesRouter: ExercisesRouterInput {
    weak var viewController: UIViewController?

    func navigateToExercise(_ exercise: ExerciseEntity) {
        viewController?.navigationController?.pushViewController(
            ExerciseModuleBuilder.build(exercise),
            animated: true
        )
    }

    // нужно что бы вернуться на экран с тренировкой
    func backTwice() {
        guard let navController = viewController?.navigationController else { return }

        let viewControllers = navController.viewControllers
        // Убедимся, что в стеке есть хотя бы два экрана перед текущим
        guard viewControllers.count >= 3 else {
            navController.popToRootViewController(animated: true)
            return
        }
        let targetVC = viewControllers[viewControllers.count - 3]
        navController.popToViewController(targetVC, animated: true)
    }

    deinit {
        print("DEINIT ROUTER")
    }
}
