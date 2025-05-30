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

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    private lazy var mainStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()

    private var setsCount = 1 {
        didSet {
            updateSetInputs()
        }
    }

    private let setsStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    private let setsLabel = UILabel()
    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)

    private var setInputViews: [SetInputRowView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.width.equalTo(view).offset(-32)
        }
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        saveButton.addAction(UIAction(handler: { [weak self] _ in
            self?.item?.sets = Set(
                self?.setInputViews.map{
                    ExerciseSet(
                        exercise: self!.item!,
                        reps: Int($0.repsField.text!) ?? 1,
                        weight: Decimal(string: $0.weightField.text!) ?? 0.0
                    )
                } ?? []
            )
        }), for: .touchUpInside)
    }
    var item: WorkoutExercise?
    func showItem(_ item: WorkoutExercise) {
        self.title = item.exercise?.name.localized
        self.item = item
        setupSetsHeader()
        mainStack.addArrangedSubview(setsStackView)
        updateSetInputs()
        setsCount = item.setsArray.isEmpty ? 1 : item.setsArray.count
        item.setsArray.enumerated().forEach { index, exerciseSet in
            setInputViews[index].setValues(reps: exerciseSet.reps, weight: exerciseSet.weight)
        }
    }
    private func setupSetsHeader() {
        let headerLabel = UILabel()
        headerLabel.text = "Подходы"
        headerLabel.font = .boldSystemFont(ofSize: 18)

        minusButton.setTitle("-", for: .normal)
        plusButton.setTitle("+", for: .normal)
        minusButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        plusButton.titleLabel?.font = .boldSystemFont(ofSize: 22)

        minusButton.addTarget(self, action: #selector(decreaseSet), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseSet), for: .touchUpInside)

        setsLabel.text = "\(setsCount)"
        setsLabel.font = .systemFont(ofSize: 18)
        setsLabel.textAlignment = .center

        let controlsStack = UIStackView(arrangedSubviews: [minusButton, setsLabel, plusButton])
        controlsStack.axis = .horizontal
        controlsStack.spacing = 12
        controlsStack.alignment = .center

        let headerStack = UIStackView(arrangedSubviews: [headerLabel, controlsStack])
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center

        mainStack.addArrangedSubview(headerStack)
    }

    private func updateSetInputs() {
        setsLabel.text = "\(setsCount)"
        setInputViews.forEach { $0.removeFromSuperview() }
        setInputViews.removeAll()

        for index in 1...setsCount {
            let inputRow = SetInputRowView(setNumber: index)
            setsStackView.addArrangedSubview(inputRow)
            setInputViews.append(inputRow)
        }
    }

    @objc private func increaseSet() {
        if setsCount < 10 {
            setsCount += 1
        }
    }

    @objc private func decreaseSet() {
        if setsCount > 1 {
            setsCount -= 1
        }
    }
}
