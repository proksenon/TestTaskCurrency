//
//  CurrencyTableViewDelegate.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Класс делегата таблицы
final class CurrencyTableViewDelegate: NSObject, UITableViewDelegate {

	weak var output: CurrencyTableViewDelegateOutput?

	init(output: CurrencyTableViewDelegateOutput) {
		super.init()
		self.output = output
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

}
