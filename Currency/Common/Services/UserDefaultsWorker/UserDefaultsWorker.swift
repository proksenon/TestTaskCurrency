//
//  UserDefaultsWorker.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

final class UserDefaultsWorker: UserDefaultsWorkerProtocol {
	private let defaults: UserDefaults

	init(defaults: UserDefaults = UserDefaults.standard) {
		self.defaults = defaults
	}

	func removeObjects(urls: [String]) {
		for url in urls {
			defaults.removeObject(forKey: url)
			defaults.synchronize()
		}
	}

	func setObject(for key: String, object: Any?) {
		defaults.set(object, forKey: key)
		defaults.synchronize()
	}

	func getObject(for key: String)->Any? {
		let object = defaults.object(forKey: key)
		return object
	}
	func setObjectWithDecoder<T: Encodable>(for key: String, object: T) {
		let encoder = JSONEncoder()
		guard let encoded = try? encoder.encode(object) else  { return }
		defaults.set(encoded, forKey: key)
		defaults.synchronize()
	}

	func getObjectWithDecoder<T: Decodable>(for key: String)-> T? {
		let decoder = JSONDecoder()
		guard let encodingData = defaults.object(forKey: key) as? Data,
			  let decodedData = try? decoder.decode(T.self, from: encodingData) else { return nil}
				return decodedData
	}

}
