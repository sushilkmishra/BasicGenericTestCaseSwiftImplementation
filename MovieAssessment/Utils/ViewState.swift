//
//  ViewState.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}
