import UIKit
import SnapKit
import Kingfisher

class MuscleCell: UITableViewCell {
    private let nameLabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    private let image = {
        let img = UIImageView()
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        return img
    }()
    private lazy var textStack = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            descriptionLabel,
        ])
        stack.axis = .vertical
        return stack
    }()
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            image,
            textStack,
        ])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
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
        contentView.addSubview(mainStack)
        image.snp.makeConstraints {
            $0.size.equalTo(80)
        }
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(_ item: MuscleEntity) {
        nameLabel.text = item.name.localized
        descriptionLabel.text = item.description.localized
        image.image = item.uiImage
    }
}
