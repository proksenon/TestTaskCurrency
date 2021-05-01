//
//  SubLabelDecorator.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Label decorator in style Sub
struct SubLabelDecorator: ViewDecorator {
	/// Title of Label
	let title: String

	func decorate(view: UIView) {
		guard let label = view as? UILabel else { return }
		label.backgroundColor = .clear
		label.font = label.font.withSize(14)
		label.textAlignment = .center
		label.textColor = .gray
		label.text = title
	}

}
