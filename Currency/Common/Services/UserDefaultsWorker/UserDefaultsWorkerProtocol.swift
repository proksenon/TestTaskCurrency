//
//  UserDefaultsWorkerProtocol.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

protocol UserDefaultsWorkerProtocol {
	///  Удаляет в юзер дефолтс данные о картинках
	func removeObjects(urls: [String])
	///  Устанавливает данные в UserDefaults
	func setObject(for key: String, object: Any?)
	///  Получает данные в UserDefaults
	func getObject(for key: String)->Any?
	///  Устанавливает данные в UserDefaults с декодером
	func setObjectWithDecoder<T: Encodable>(for key: String, object: T)
	///  Получает данные в UserDefaults с декодером
	func getObjectWithDecoder<T: Decodable>(for key: String)-> T?
}
