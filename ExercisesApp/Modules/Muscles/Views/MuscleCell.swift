import UIKit
import SnapKit
import Kingfisher

class MuscleCell: UITableViewCell {
    private let nameLabel = UILabel()
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
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
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(_ item: MuscleEntity) {
        nameLabel.text = item.name
    }
}
