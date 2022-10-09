//
//  ViewController.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import UIKit
import ProgressHUD

class ViewController<DataProcessor: ViewModel>: UIViewController {
    //MARK:- Vars
    var viewModel: DataProcessor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ProgressHUD.animationType = .circleStrokeSpin

    }
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ProgressHUD.dismiss()
    }
}
extension ViewController {
    func startLoading() {
        ProgressHUD.show()
        self.view.isUserInteractionEnabled = false
    }

    func stopLoading() {
        self.view.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
// MARK: RequestDelegate
extension ViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                self.startLoading()
            case .success:
                self.stopLoading()
            case .error(_):
                self.stopLoading()
            }
        }
    }
}
