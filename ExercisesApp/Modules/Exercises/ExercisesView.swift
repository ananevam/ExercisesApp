import UIKit
import SnapKit

protocol ExercisesViewInput: AnyObject {
    var output: ExercisesViewOutput? { get set }
    func showExercises(_ exercises: [Exercise])

}
protocol ExercisesViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectExercise(_ exercise: Exercise)
    func searchTextChanged(_ text: String?)
}

class ExercisesView: ViewController, ExercisesViewInput, UISearchResultsUpdating {
    var output: ExercisesViewOutput?
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
    private var searchController: UISearchController!
    private var exercises: [Exercise] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    func showExercises(_ exercises: [Exercise]) {
        self.exercises = exercises
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }

    private func setupUI() {
        title = "Exercises"
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search exercises"
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    func updateSearchResults(for searchController: UISearchController) {
        output?.searchTextChanged(searchController.searchBar.text)
    }
}

extension ExercisesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExerciseCell.identifier, for: indexPath
        ) as? ExerciseCell else {
            return UITableViewCell()
        }
        let exercise = exercises[indexPath.row]
        cell.configure(exercise)
        return cell
    }
}

extension ExercisesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exercises[indexPath.row]
        output?.didSelectExercise(exercise)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
