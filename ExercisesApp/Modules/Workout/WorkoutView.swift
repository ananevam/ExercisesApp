import UIKit

protocol WorkoutViewInput: AnyObject {
    var output: WorkoutViewOutput? { get set }
    func showItems(_ items: [Workout])

}
protocol WorkoutViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectItem(_ item: Workout)
}

class WorkoutView: ViewController, WorkoutViewInput {
    var output: WorkoutViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    func showItems(_ items: [Workout]) {
        // self.items = items
        // tableView.reloadData()
    }
}
