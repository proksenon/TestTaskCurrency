//
//  Main.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Label decorator in style Main
struct MainLabelDecorator: ViewDecorator {
	/// Title of Label
	let title: String

	func decorate(view: UIView) {
		guard let label = view as? UILabel else { return }
		label.backgroundColor = .clear
		label.font = UIFont(name: "Futura Medium", size: 18)
		label.textAlignment = .left
		label.textColor = .systemGray
		label.text = title
	}

}
