import UIKit

protocol MusclesViewInput: AnyObject {
    var output: MusclesViewOutput? { get set }
    func showItems(_ items: [MuscleEntity])

}
protocol MusclesViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectItem(_ item: MuscleEntity)
}

class MusclesView: ViewController, MusclesViewInput {
    var output: MusclesViewOutput?
    private var items: [MuscleEntity] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.keyboardDismissMode = .onDrag
        tableView.register(MuscleCell.self, forCellReuseIdentifier: MuscleCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }
    private func setupUI() {
        title = "Muscles"
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func showItems(_ items: [MuscleEntity]) {
        self.items = items
    }
}

extension MusclesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MuscleCell.identifier, for: indexPath
        ) as? MuscleCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(item)
        return cell
    }
}

extension MusclesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        output?.didSelectItem(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
