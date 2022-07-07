//
//  LoadingScreenViewController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class LoadingScreenViewController: BaseViewController {
    
    private let titleLabel = UILabel()
    
    var viewModel = LoadingScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUserLoginFlow()
    }
}
// MARK: - View Config
extension LoadingScreenViewController {
    private func configureViews() {
        titleLabel.font = UIFont.h2
        titleLabel.text = Localized.Loading.title
        view.addSubview(titleLabel)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}

// MARK: -
extension LoadingScreenViewController {
    
    /// Decide user flow
    private func checkUserLoginFlow() {
        DispatchQueue.main.async {
            if self.viewModel.hasUserSignedIn {
                self.appCoordinator?.showHome(forceReplace: true)
            } else {
                self.appCoordinator?.showLogin()
            }
        }
    }

}
