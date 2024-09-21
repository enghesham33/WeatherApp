//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import UIKit
import SwiftLoader
import Toast_Swift

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController: BaseViewProtocol {
    
    func showLoader() {
        SwiftLoader.show(animated: true)
    }
    
    func hideLoader() {
        SwiftLoader.hide()
    }
    
    func showToast(message: String?) {
        view.makeToast(message)
    }
}
