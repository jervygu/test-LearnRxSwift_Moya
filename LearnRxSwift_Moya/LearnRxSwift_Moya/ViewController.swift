//
//  ViewController.swift
//  LearnRxSwift_Moya
//
//  Created by Jeff Umandap on 3/23/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private var viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUser(id: "2")
        
        viewModel.userResponse.subscribe { userResponse in
            // print("userResponse element: \(userResponse.element)")
        }.disposed(by: disposeBag)

        
        viewModel.fetchAllUsers()
        
        viewModel.loginUser()
        
    }


}

