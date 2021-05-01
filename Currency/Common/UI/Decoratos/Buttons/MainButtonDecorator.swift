//
//  MainButtonDecorator.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Decorator Main Button
struct MainButtonDecorator: ViewDecorator {

	/// Title of Label
	let title: String
	/// TextColor
	var color: UIColor = .green

	func decorate(view: UIView) {
		guard let button = view as? UIButton else { return }
		button.backgroundColor = color
		button.setTitle(title, for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.setTitleColor(.gray, for: .highlighted)
	}

}
