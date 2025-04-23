import UIKit
import SnapKit
import Kingfisher

class ExerciseCell: UITableViewCell {
    private let image = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    private let nameLabel = UILabel()
    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            image,
            rightStack
        ])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    private lazy var rightStack = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            descriptionLabel,
        ])

        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        image.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
        contentView.addSubview(mainStack)
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(_ exercise: ExerciseEntity) {
        nameLabel.text = exercise.name.localized
        descriptionLabel.text = exercise.description.localized

        if let imageUrl = exercise.imageUrl {
            self.image.kf.setImage(with: imageUrl)
        }
    }
    func configure(_ workoutExercise: WorkoutExercise) {
        nameLabel.text = workoutExercise.exercise?.name.localized ?? "None"
        descriptionLabel.text = workoutExercise.exercise?.description.localized ?? "None"

        if let imageUrl = workoutExercise.exercise?.imageUrl {
            self.image.kf.setImage(with: imageUrl)
        }
    }
}
