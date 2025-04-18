import UIKit
import Kingfisher

protocol ExerciseViewInput: AnyObject {
    var output: ExerciseViewOutput? { get set }
    func showExercise(_ exercise: ExerciseEntity)

}
protocol ExerciseViewOutput: AnyObject {
    func viewDidLoad()
}

class ExerciseView: ViewController, ExerciseViewInput {
    var output: ExerciseViewOutput?
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    private lazy var stepsStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [
            slideShowView,
            titleLabel,
            descriptionLabel,
            stepsStack
        ])
        stack.axis = .vertical
        // stack.alignment = .leading
        // stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()

    private lazy var slideShowView = {
        let slideShow = SlideshowView()
        return slideShow
    }()
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

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.width.equalTo(view).offset(-32)
        }
    }
    func showExercise(_ exercise: ExerciseEntity) {
        title = exercise.name.localized
        titleLabel.text = exercise.name.localized
        descriptionLabel.text = exercise.description.localized
        slideShowView.imageUrls = exercise.imageUrls

        exercise.instructions.localized.enumerated().forEach { index, text in
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "\(index + 1). \(text)"
            stepsStack.addArrangedSubview(label)
        }
    }
}
