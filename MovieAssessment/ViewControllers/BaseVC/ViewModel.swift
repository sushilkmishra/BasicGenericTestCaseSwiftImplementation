//
//  ViewModel.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation
class ViewModel: NSObject {
    
    weak var delegate: RequestDelegate?
    var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    override init() {
        self.state = .idle
    }
    
}
