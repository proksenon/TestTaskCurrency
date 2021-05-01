//
//  CurrencyPresenter.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation
final class CurrencyPresenter {

	weak var view: CurrencyViewInput?
	var interactor: CurrencyInteractorInput?
	var router: CurrencyRouterInput?
	var currencyTableViewDelegate: CurrencyTableViewDelegate?
	var currencyTableViewDataSource: CurrencyTableViewDataSource?

	private var monthlyValue: [Record] = [] {
		didSet {
			monthlyValue = monthlyValue.reversed()
			view?.reloadTableView()
		}
	}

	private var limitedValue = LimitedValue() {
		didSet {
			view?.reloadTableView()
		}
	}


	init(view: CurrencyViewInput) {
		self.view = view
	}
	
}

//MARK: -CurrencyViewOutput
extension CurrencyPresenter: CurrencyViewOutput {
	func configureView() {
		loadData()
	}

}

//MARK: -CurrencyInteractorOutput
extension CurrencyPresenter: CurrencyInteractorOutput {

}

//MARK: -CurrencyModuleInput
extension CurrencyPresenter: CurrencyModuleInput {

}

//MARK: -CurrencyTableViewDataSourceOutput
extension CurrencyPresenter: CurrencyTableViewDataSourceOutput {
	func numberOfRows(section: Int) -> Int {
		section == 0 ? 1: monthlyValue.count
	}

	func itemFor(indexPath: IndexPath) -> CellItemProtocol {
		indexPath.section == 0 ? limitedValue : monthlyValue[indexPath.row]
	}

	func section() -> Int { 2 }
}

//MARK: -CurrencyTableViewDelegateOutput
extension CurrencyPresenter: CurrencyTableViewDelegateOutput {
	
}

//MARK: -Private Methods
extension CurrencyPresenter {

	private func loadData() {
		guard getCache(), let lastRecord = monthlyValue.first else { getMonthlyCurs(); return }
		isUpdate(dateString: lastRecord.date) ? getMonthlyCurs() : ()
	}

	private func getCache() -> Bool {
		getLimitedValue()
		guard let records = interactor?.getCahchedMonthly() else { return false}
		monthlyValue = records
		return true
	}

	private func getMonthlyCurs() {
		view?.startLoading()
		interactor?.getMonthlyCurs(completion: { [weak self] (valueCurs) in
			guard let self = self else { return }
			guard case let Result.success(valueCurse) = valueCurs,
				  let monthlyValue = valueCurse.record else { self.handlerErrors(valueCurs); return }
			self.monthlyValue = monthlyValue
			self.saveData(records: monthlyValue)
			self.view?.stopLoading()
		})
	}

	private func getLimitedValue() {
		let limited = interactor?.getLimitedValue()
		limited == nil ? interactor?.setLimitedValue(value: "0,0") : ()
		let actionBlock: (String?)->Void = { [weak self] (value) in
			guard let value = value, let correctValue = self?.checkCorrectString(str: value) else { return }
			self?.interactor?.setLimitedValue(value: correctValue)
		}
		limitedValue = LimitedValue(value: limited ?? "0,0", actionBlock: actionBlock)
	}

	private func isUpdate(dateString: String?) -> Bool {
		guard let dateString = dateString else { return true }
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale.current
		guard let date = formatter.date(from: dateString) else { return true}
		return date.isBefore()
	}

	private func saveData(records: [Record]) {
		interactor?.setCahchedMonthly(records: records)
	}

	private func handlerErrors(_ error: Result<ValCurs, Errors>) {
		guard case let Result.failure(error) = error else { return }
		// можно обработать все ошибки
		switch error {
		default:
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				self.router?.showAlert(error: ErrorModel())
			}
		}
		view?.stopLoading()
	}

	private func checkCorrectString(str: String)->String {
		var appendingResult = ""
		if str.firstIndex(of: ",") != nil {
			appendingResult = "0"
		} else if str.isEmpty {
			appendingResult = "0,0"
		}
		return str.appending(appendingResult)
	}

}
