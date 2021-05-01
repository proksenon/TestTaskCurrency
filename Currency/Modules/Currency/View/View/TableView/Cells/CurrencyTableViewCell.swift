//
//  CurrencyTableViewCell.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell, TableViewCellProtocol {

	private let dateLabel = UILabel()
	private let valueLabel = UILabel()
	private let currencyLabel = UILabel()

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
		guard let record = item as? Record else { return }
		dateLabel.text = record.date
		valueLabel.text = record.value
		currencyLabel.text = "Rub = 1 USD"
	}

	//MARK: -Private Methods
	private func setupCell() {
		[dateLabel, valueLabel, currencyLabel].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview($0)
			$0.decorate(with: SubLabelDecorator(title: ""))
		}
		setupValueLabel()
		setupDateLabel()
		setupCurrencyLabel()
	}

	private func setupDateLabel() {
		NSLayoutConstraint.activate([dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
									 dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
									 dateLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor)])
		dateLabel.textAlignment = .left
	}

	private func setupValueLabel() {
		NSLayoutConstraint.activate([valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
									 valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)])
	}

	private func setupCurrencyLabel() {
		NSLayoutConstraint.activate([currencyLabel.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 10),
									 currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
									 currencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)])
		currencyLabel.textAlignment = .right
	}

}

