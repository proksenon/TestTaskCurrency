//
//  CurrencyTableView.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Таблица currency
final class CurrencyTableView: UITableView {

	init() {
		super.init(frame: .zero, style: .grouped)
		register(LimitedCurrencyTableViewCell.self, forCellReuseIdentifier: CellsID.limitedCell)
		register(CurrencyTableViewCell.self, forCellReuseIdentifier: CellsID.currency)
		tableFooterView = UIView()
		separatorStyle = .none
		backgroundColor = .systemGray6
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
