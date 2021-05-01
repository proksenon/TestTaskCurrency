//
//  NetworkService.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation
import XMLCoder

typealias ComplitionValueCurse = (Result<ValCurs, Errors>)-> Void

final class NetworkService: NetworkServiceProtocol {

	private var session: URLSession
	private var dispatchQueue: DispatchQueue
	private let baseUrl = "http://www.cbr.ru/scripts/XML_"

	init(session: URLSession = URLSession.shared, dispatchQueue: DispatchQueue = DispatchQueue.main) {
		self.session = session
		self.dispatchQueue = dispatchQueue
	}

	public func getData(url: URL, completion: @escaping (Result<Data?, Errors>) -> ()) {
		session.dataTask(with: url) { (data, response, error) in
			self.dispatchQueue.async {
				error == nil ? completion(.success(data)) : completion(.failure(.network))
			}
		}.resume()
	}

	func getLastCurse(completion: @escaping ComplitionValueCurse) {
		guard let url = URL(string: baseUrl + "daily.asp") else { return }
		getValueCurs(with: url) { (valueCurs) in completion(valueCurs) }
	}
	func getMonthlyCurs(firstDate: String, secondDate: String, completion: @escaping ComplitionValueCurse) {
		let urlString = "dynamic.asp?date_req1=\(firstDate)&date_req2=\(secondDate)&VAL_NM_RQ=R01235"
		guard let url = URL(string: baseUrl + urlString) else { return }
		getValueCurs(with: url) { (valueCurs) in completion(valueCurs) }
	}

	func cancel() {
		session.invalidateAndCancel()
	}

	private func getValueCurs(with url: URL, completion: @escaping ComplitionValueCurse) {
		getData(url: url) { (result) in
			guard case let Result.success(dataOptional) = result, let data = dataOptional else { return }
			do {
				let valueCurs = try XMLDecoder().decode(ValCurs.self, from: data)
				completion(.success(valueCurs))
			} catch {
				print("decode error")
				print(error)
				completion(.failure(.decode))
			}
		}
	}

}
