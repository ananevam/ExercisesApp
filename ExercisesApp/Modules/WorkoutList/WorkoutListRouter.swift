import UIKit

protocol WorkoutListRouterInput {
    func navigateToItem(_ item: Workout)
    func presentAddWorkoutAlert(completion: @escaping (String) -> Void)
    func presentEditWorkoutAlert(_ item: Workout, completion: @escaping (String) -> Void)
    func showDeleteConfirmation(_ workout: Workout, completion: @escaping () -> Void)
}

class WorkoutListRouter: WorkoutListRouterInput {
    weak var viewController: UIViewController?

    func navigateToItem(_ item: Workout) {
        viewController?.navigationController?.pushViewController(
            WorkoutModuleBuilder.build(item),
            animated: true
        )
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
    func presentEditWorkoutAlert(_ item: Workout, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Edit workout", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
            textField.text = item.name
        }

        let add = UIAlertAction(title: "Save", style: .default) { _ in
            if let name = alert.textFields?.first?.text, !name.isEmpty {
                completion(name)
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(add)

        viewController?.present(alert, animated: true)
    }
    func showDeleteConfirmation(_ workout: Workout, completion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: "Delete workout",
            message: "Are you sure you want to delete \"\(workout.name)\"?",
            preferredStyle: .alert
        )

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {_ in
            completion()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        viewController?.present(alert, animated: true)
    }
}
