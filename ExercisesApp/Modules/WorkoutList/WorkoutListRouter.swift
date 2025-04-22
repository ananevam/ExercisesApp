import UIKit

protocol WorkoutListRouterInput {
    func navigateToItem(_ item: Workout)
    func presentAddWorkoutAlert(completion: @escaping (String) -> Void)
}

class WorkoutListRouter: WorkoutListRouterInput {
    weak var viewController: UIViewController?

    func navigateToItem(_ item: Workout) {
        // viewController?.navigationController?.pushViewController(
        //     ItemModuleBuilder.build(item),
        //     animated: true
        // )
    }
    func presentAddWorkoutAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Create workout", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Name" }

        let add = UIAlertAction(title: "Create", style: .default) { _ in
            if let name = alert.textFields?.first?.text, !name.isEmpty {
                completion(name)
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(add)

        viewController?.present(alert, animated: true)
    }
}
