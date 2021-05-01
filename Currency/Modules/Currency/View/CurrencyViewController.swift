//
//  CurrencyViewController.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

final class CurrencyViewController: UIViewController {

	var output: CurrencyViewOutput?
	let currencyView = CurrencyView()
	private var configurator = CurrencyConfigurator()

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		output?.configureView()
	}

	override func loadView() {
		super.loadView()
		view = currencyView
	}


}

//MARK: -CurrencyViewInput
extension CurrencyViewController: CurrencyViewInput {

	func reloadTableView() {
		currencyView.tableView.reloadData()
	}

	func startLoading() {
		currencyView.startLoading()
	}

	func stopLoading() {
		currencyView.stopLoading()
	}
}
