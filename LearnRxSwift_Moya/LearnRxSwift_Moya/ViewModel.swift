//
//  ViewModel.swift
//  LearnRxSwift_Moya
//
//  Created by Jeff Umandap on 3/23/23.
//

import Foundation
import Moya
import RxSwift


class ViewModel {
    
    private let service: MoyaProvider<MoyaService>
    private var disposeBag = DisposeBag()
    
    var userResponse = PublishSubject<UserResponse>()
    
    init(service: MoyaProvider<MoyaService> = MoyaProvider<MoyaService>()) {
        self.service = service
    }
    
    func fetchUser(id: String) {
        service.rx.request(.getUser(userID: id)).subscribe { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case let .success(response):
                print("response: \(response)")
                do {
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    print(try response.mapJSON())
                    
                    let userResponse = try filterResponse.map(UserResponse.self, using: JSONDecoder())
                    
                    self.userResponse.onNext(userResponse)
                    
                } catch {
                    print("fetchUser: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            
        }.disposed(by: disposeBag)
    }
    
    
    func fetchAllUsers() {
        service.rx.request(.getAllUsers(page: "2")).subscribe { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case let .success(response):
                do {
                    print("fetchAllUsers: \(try response.mapJSON())")
                } catch {
                    print("fetchAllUsers: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            
        }.disposed(by: disposeBag)
    }
    
    
    
    func loginUser() {
        service.rx.request(.login(email: "eve.holt@reqres.in", password: "cityslicka")).subscribe { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case let .success(response):
                do {
                    print("loginUser: \(try response.mapJSON())")
                } catch {
                    print("loginUser: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            
        }.disposed(by: disposeBag)
    }
    
}

