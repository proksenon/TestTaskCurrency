//
//  ActivityIndicator.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 01.05.2021.
//

import UIKit

final class ActivityView: UIView {

	private let activityIndicator = UIActivityIndicatorView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setActivivty()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		activityIndicator.center = center
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	private func setActivivty() {
		addSubview(activityIndicator)
		activityIndicator.style = .large
		activityIndicator.center = center
	}

	///  Остонавливает индикатор загрузки
	func stopActivity() { activityIndicator.stopAnimating() }

	///  Запускает индикатор загрузки
	func startActivity() { activityIndicator.startAnimating() }
}
