import UIKit

protocol WorkoutExerciseEditorViewInput: AnyObject {
    var output: WorkoutExerciseEditorViewOutput? { get set }
    func showItem(_ item: WorkoutExercise)

}
protocol WorkoutExerciseEditorViewOutput: AnyObject {
    func viewDidLoad()
}

class WorkoutExerciseEditorView: ViewController, WorkoutExerciseEditorViewInput {
    var output: WorkoutExerciseEditorViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    func showItem(_ item: WorkoutExercise) {
        self.title = item.exercise?.name.localized
        // self.items = items
        // tableView.reloadData()
    }
}
