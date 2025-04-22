import UIKit
import SnapKit
import Kingfisher

class WorkoutCell: UITableViewCell {
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private let nameLabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
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
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        bgView.addSubview(mainStack)

        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(_ item: Workout) {
        nameLabel.text = item.name
    }
}
