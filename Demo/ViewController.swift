//
//  ViewController.swift
//  Demo
//
//  Created by Aleksandar Vacić on 19.8.17..
//  Copyright © 2017. Radiant Tap. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
	//	UI

	@IBOutlet private weak var textView: UITextView!

	//	Dependencies

	fileprivate var urlSessionConfiguration: URLSessionConfiguration = {
		let c = URLSessionConfiguration.default
		c.allowsCellularAccess = true
		c.httpCookieAcceptPolicy = .never
		c.httpShouldSetCookies = false
		c.httpAdditionalHeaders = [
			"User-Agent": "iOS TEST",
			"Accept-Charset": "utf-8",
			"Accept-Encoding": "gzip, deflate",
			"Accept": "application/json"
		]
		c.requestCachePolicy = .reloadIgnoringLocalCacheData
		return c
	}()

	lazy fileprivate var urlSession = URLSession(configuration: urlSessionConfiguration)

	//	View Lifecycle

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		let path = "https://t1.aplus.rs/coordinator/api/slides.json"
		guard let url = URL(string: path) else { return }

		let tsStart = Date()

		let task = urlSession.dataTask(with: url) {
			data, urlResponse, error in

			//	measure response time
			let period = Date().timeIntervalSince(tsStart) * 1000
			print("\t⏱: \( period ) ms")


			//	insert received data into text view
			if let data = data, let str = String(data: data, encoding: .utf8) {
				DispatchQueue.main.async {
					[weak self] in
					self?.textView.text = str
				}
			}
		}

		task.resume()
	}
}

