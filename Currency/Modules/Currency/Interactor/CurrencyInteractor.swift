//
//  CurrencyInteractor.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

final class CurrencyInteractor {

	weak var output: CurrencyInteractorOutput?
	private var networkService: NetworkServiceProtocol?
	private var userDefaultsWorker: UserDefaultsWorkerProtocol?

	init(presenter: CurrencyInteractorOutput,
		 networkService: NetworkServiceProtocol = NetworkService(),
		 userDefaultsWorker: UserDefaultsWorkerProtocol = UserDefaultsWorker()) {
		self.output = presenter
		self.networkService = networkService
		self.userDefaultsWorker = userDefaultsWorker
	}

	private func formaterDate(date: Date)->String {
		let formatter: DateFormatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy"
		return formatter.string(from: date)
	}

}

//MARK: -CurrencyInteractorInput
extension CurrencyInteractor: CurrencyInteractorInput {

	func getLimitedValue()-> String? {
		userDefaultsWorker?.getObject(for: Keys.limited) as? String
	}

	func setLimitedValue(value: String) {
		userDefaultsWorker?.setObject(for: Keys.limited, object: value)
	}

	func getCahchedMonthly() -> [Record]? {
		userDefaultsWorker?.getObjectWithDecoder(for: Keys.monthlyCached)
	}

	func setCahchedMonthly(records: [Record]) {
		userDefaultsWorker?.setObjectWithDecoder(for: Keys.monthlyCached, object: records)
	}

	func getMonthlyCurs(completion: @escaping ComplitionValueCurse) {
		guard let earlyDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else { return }
		let firstDate = formaterDate(date: earlyDate)
		let secondDate = formaterDate(date: Date())
		networkService?.getMonthlyCurs(firstDate: firstDate, secondDate: secondDate) { (valueCurs) in
			completion(valueCurs)
		}
	}
}
