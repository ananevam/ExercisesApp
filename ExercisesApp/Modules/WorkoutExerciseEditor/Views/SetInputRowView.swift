import UIKit
import SnapKit

class SetInputRowView: UIView {

    private let setLabel = UILabel()
    let repsField = UITextField()
    let weightField = UITextField()

    init(setNumber: Int) {
        super.init(frame: .zero)
        setupUI(setNumber: setNumber)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValues(reps: Int? = nil, weight: Decimal? = nil) {
        repsField.text = reps.map { String($0) }
        weightField.text = weight != nil ? NSDecimalNumber(decimal: weight!).stringValue : ""
    }

    private func setupUI(setNumber: Int) {
        setLabel.text = "Подход \(setNumber)"
        setLabel.font = .systemFont(ofSize: 16)

        repsField.placeholder = "Повторения"
        weightField.placeholder = "Вес (кг)"
        repsField.borderStyle = .roundedRect
        weightField.borderStyle = .roundedRect
        repsField.keyboardType = .numberPad
        weightField.keyboardType = .decimalPad

        let fieldsStack = UIStackView(arrangedSubviews: [repsField, weightField])
        fieldsStack.axis = .horizontal
        fieldsStack.spacing = 10
        fieldsStack.distribution = .fillEqually

        let verticalStack = UIStackView(arrangedSubviews: [setLabel, fieldsStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 4

        addSubview(verticalStack)
        verticalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
