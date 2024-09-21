//
//  BaseViewProtocol.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    
    func showLoader()
    func hideLoader()
    func showToast(message: String?)
}
