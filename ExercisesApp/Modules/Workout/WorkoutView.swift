import UIKit

protocol WorkoutViewInput: AnyObject {
    var output: WorkoutViewOutput? { get set }
    func showWorkout(_ item: Workout)
}
protocol WorkoutViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectItem(_ item: Workout)
    func didTapDelete(_ item: WorkoutExercise)
    func didTapAddExercise()
    func didTapEdit(_ item: WorkoutExercise)
}

class WorkoutView: ViewController, WorkoutViewInput {
    var output: WorkoutViewOutput?

    private var workoutExercises: [WorkoutExercise] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.keyboardDismissMode = .onDrag
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: ExerciseCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }
    private func setupUI() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
    }
    @objc private func addTapped() {
        output?.didTapAddExercise()
    }
    func showWorkout(_ item: Workout) {
        title = item.name
        self.workoutExercises = item.exercisesArray
        tableView.reloadData()
    }
}

extension WorkoutView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutExercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExerciseCell.identifier, for: indexPath
        ) as? ExerciseCell else {
            return UITableViewCell()
        }
        let item = workoutExercises[indexPath.row]
        cell.configure(item)
        return cell
    }
}

extension WorkoutView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let item = workoutExercises[indexPath.row]
        let deleteAction = UIContextualAction(
            style: .destructive, title: nil
        ) { [weak self] (_, _, completionHandler) in
            self?.output?.didTapDelete(item)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let editAction = UIContextualAction(
            style: .normal, title: nil
        ) { [weak self] (_, _, completionHandler) in
            self?.output?.didTapEdit(item)
            completionHandler(true)
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemOrange

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
