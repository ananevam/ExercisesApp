import UIKit
import Kingfisher

protocol ExerciseViewInput: AnyObject {
    var output: ExerciseViewOutput? { get set }
    func showExercise(_ exercise: Exercise)

}
protocol ExerciseViewOutput: AnyObject {
    func viewDidLoad()
}

class ExerciseView: ViewController, ExerciseViewInput {
    var output: ExerciseViewOutput?
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [
            slideShowView
        ])
        stack.axis = .vertical
        stack.alignment = .center
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
        // setup()
    }
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }

//        slideShowView.snp.makeConstraints {
//            $0.width.equalToSuperview().multipliedBy(0.5)
//            $0.height.equalTo(slideShowView.snp.width)
//        }
    }
    func showExercise(_ exercise: Exercise) {
        title = exercise.name
        slideShowView.imageUrls = exercise.imageUrls
    }
}
