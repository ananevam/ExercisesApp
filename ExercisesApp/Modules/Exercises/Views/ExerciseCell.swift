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
    private let levelLabel = UILabel()
    private let categoryLabel = UILabel()
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
            levelLabel,
            categoryLabel,
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
            make.size.equalTo(40)
        }
        contentView.addSubview(mainStack)
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(_ exercise: Exercise) {
        nameLabel.text = exercise.name
        levelLabel.text = "Level: \(exercise.level)"
        categoryLabel.text = "Category: \(exercise.category)"

        if let imageUrl = exercise.imageUrl {
            self.image.kf.setImage(with: imageUrl)
        }
    }
}
