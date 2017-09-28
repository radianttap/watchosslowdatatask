//
//  ExtensionDelegate.swift
//  DemoWatch Extension
//
//  Created by Aleksandar Vacić on 27.9.17..
//  Copyright © 2017. Radiant Tap. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		ping()
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
    }


	//	TEST CODE

	//	Dependencies

	fileprivate var urlSessionConfiguration: URLSessionConfiguration = {
		let c = URLSessionConfiguration.default
		c.allowsCellularAccess = true
		c.httpCookieAcceptPolicy = .never
		c.httpShouldSetCookies = false
		c.httpAdditionalHeaders = [
			"User-Agent": "WatchOS TEST",
			"Accept-Charset": "utf-8",
			"Accept-Encoding": "gzip, deflate",
			"Accept": "application/json"
		]
		c.requestCachePolicy = .reloadIgnoringLocalCacheData
		return c
	}()

	lazy fileprivate var urlSession = URLSession(configuration: urlSessionConfiguration)

	func ping() {
		let path = "https://t1.aplus.rs/coordinator/api/slides.json"
		guard let url = URL(string: path) else { return }

		let tsStart = Date()

		let task = urlSession.dataTask(with: url) {
			data, urlResponse, error in

			//	measure response time
			let period = Date().timeIntervalSince(tsStart) * 1000
			print("\t⏱: \( period ) ms")
		}

		task.resume()
	}
}
