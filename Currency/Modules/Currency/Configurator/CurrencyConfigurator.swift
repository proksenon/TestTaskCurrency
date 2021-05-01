//
//  CurrencyConfigurator.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

final class CurrencyConfigurator: CurrencyConfiguratorProtocol {

	func configure(with viewController: CurrencyViewController) {
		let presenter = CurrencyPresenter(view: viewController)
		let interactor = CurrencyInteractor(presenter: presenter)
		let router = CurrencyRouter(viewController: viewController)

		viewController.output = presenter
		presenter.interactor = interactor
		presenter.router = router

		let currencyTableViewDelegate = CurrencyTableViewDelegate(output: presenter)
		let currencyTableViewDataSource = CurrencyTableViewDataSource(output: presenter)
		presenter.currencyTableViewDelegate = currencyTableViewDelegate
		presenter.currencyTableViewDataSource = currencyTableViewDataSource
		viewController.currencyView.tableView.delegate = currencyTableViewDelegate
		viewController.currencyView.tableView.dataSource = currencyTableViewDataSource
	}

}
