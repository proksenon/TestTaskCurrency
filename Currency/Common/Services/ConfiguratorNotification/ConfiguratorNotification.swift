//
//  ConfiguratorNotification.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

final class ConfiguratorNotification {
	private let notificationService: NotificationServiceProtocol
	private let networkService: NetworkServiceProtocol
	private let userDefaultsWorker: UserDefaultsWorkerProtocol

	init(notificationService: NotificationServiceProtocol = NotificationService(),
		 networkService: NetworkServiceProtocol = NetworkService(),
		 userDefaultsWorker: UserDefaultsWorkerProtocol = UserDefaultsWorker()) {
		self.notificationService = notificationService
		self.networkService = networkService
		self.userDefaultsWorker = userDefaultsWorker
	}

	func backGroundTask(completion: @escaping (Bool)-> Void) {
		networkService.getLastCurse { [weak self] (valueCurse) in

			guard case let Result.success(valueCurs) = valueCurse,
				  let valutes = valueCurs.valutes?.filter({ $0.charCode == Keys.usd}),
				  let usd = valutes.first,
				  let limitedValue = self?.transformToDuble(str: self?.userDefaultsWorker.getObject(for: Keys.limited) as? String),
				  let usdValue = self?.transformToDuble(str: usd.value)
			else { completion(false); return }
			let needToNotify = usdValue > limitedValue
			needToNotify ? self?.notificationService.setupPush(body: NotificationModel()) : ()
			completion(needToNotify)
		}
	}

	func cancel() {
		networkService.cancel()
	}

	private func transformToDuble(str: String?)-> Double? {
		guard let str = str else { return nil}
		return Double(str.replacingOccurrences(of: ",", with: "."))
	}
}
