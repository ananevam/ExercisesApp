import UIKit

protocol WorkoutListViewInput: AnyObject {
    var output: WorkoutListViewOutput? { get set }
    func showItems(_ items: [Workout])

}
protocol WorkoutListViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectItem(_ item: Workout)
    func didTapAddWorkout()
    func didEnterWorkoutName(_ name: String)
    func didTapEdit(_ item: Workout)
    func didTapDelete(_ item: Workout)
}

class WorkoutListView: ViewController, WorkoutListViewInput {
    var output: WorkoutListViewOutput?
    private var items: [Workout] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.keyboardDismissMode = .onDrag
        tableView.register(WorkoutCell.self, forCellReuseIdentifier: WorkoutCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }
    private func setupUI() {
        title = "Workouts"
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
        output?.didTapAddWorkout()
    }
    func showItems(_ items: [Workout]) {
        self.items = items
        tableView.reloadData()
    }
}
extension WorkoutListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WorkoutCell.identifier, for: indexPath
        ) as? WorkoutCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(item)
        return cell
    }
}

extension WorkoutListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = items[indexPath.row]
        output?.didSelectItem(exercise)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
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
