//
//  CurrencyTableViewDataSource.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Кастомная ДатаСорс для Таблицы на главном экране
final class CurrencyTableViewDataSource: NSObject, UITableViewDataSource {

	weak var output: CurrencyTableViewDataSourceOutput?

	init(output: CurrencyTableViewDataSourceOutput) {
		super.init()
		self.output = output
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		output?.section() ?? 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		output?.numberOfRows(section: section) ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let output = output else { return UITableViewCell() }
		let item = output.itemFor(indexPath: indexPath)
		guard let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier) as? TableViewCellProtocol else { return UITableViewCell()}
		cell.configureCell(with: item)
		return cell
	}

}
