//
//  LimitedCurrencyTableViewCell.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

final class LimitedCurrencyTableViewCell: UITableViewCell, TableViewCellProtocol {

	private let titleLabel = UILabel()
	private let textField = UITextField()
	private let saveButton = UIButton()
	private var actionBlock: ((String?)->Void)?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		backgroundColor = .systemGray6
		setupCell()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: -TableViewCellProtocol
	func configureCell(with item: CellItemProtocol) {
		guard let limitedValue = item as? LimitedValue else { return }
		textField.text = limitedValue.value
		actionBlock = limitedValue.actionBlock
	}

	//MARK: -Private Methods
	private func setupCell() {
		[titleLabel, textField, saveButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0)}
		setupTitleLabel()
		setupTextfield()
		setupSaveButton()
	}

	private func setupTitleLabel() {
		NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
									 titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
									 titleLabel.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -10)])
		titleLabel.decorate(with: MainLabelDecorator(title: "Set limited value"))
	}

	private func setupTextfield() {
		textField.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.7)
		textField.placeholder = "Limit"
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
		textField.leftViewMode = .always
		textField.keyboardType = .decimalPad
		textField.clearsOnBeginEditing = true
		textField.decorate(with: CornerRadiusDecorator(cornerRadius: 4))
		textField.delegate = self

		NSLayoutConstraint.activate([textField.centerYAnchor.constraint(equalTo: centerYAnchor),
									 textField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 20),
									 textField.widthAnchor.constraint(equalToConstant: Screen.width/4)])
	}

	private func setupSaveButton() {
		NSLayoutConstraint.activate([saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
									 saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
									 saveButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
									 saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
		
		saveButton.decorate(with: [MainButtonDecorator(title: "Save", color: .blue), CornerRadiusDecorator(cornerRadius: 4)])
		saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
	}

	@IBAction private func didTapSaveButton() {
		actionBlock?(textField.text)
		self.endEditing(true)
	}

	private func checkTextFieldString(text: String?, string: String)-> Bool {
		let pattern = "((^[0]{1})([,]{1}[0-9]{0,2})?)|(([1-9][0-9]*)([,][0-9]{0,4})?)"
		var result = false
		if let text = text {
			result = isValidTextInput(text: text + string, pattern: pattern)
		} else {
			result = isValidTextInput(text: string, pattern: pattern)
		}
		return result
	}

	/// Проверка валидности текстфилда
	/// - Parameters:
	///   - text: Проверяемый текст
	///   - pattern: Условие
	/// - Returns: Валдидный или не валидный
	private func isValidTextInput(text: String, pattern: String) -> Bool {
		return text.matches(pattern)
	}

}

//MARK: -UITextFieldDelegate
extension LimitedCurrencyTableViewCell: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return checkTextFieldString(text: textField.text, string: string)
	}
}
