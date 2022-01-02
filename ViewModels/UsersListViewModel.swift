//
//  UsersListViewModel.swift
//  iOSConcurrency (iOS)
//
//  Created by Vandankumar Patel on 12/30/21.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        apiService.getJSON { (result: Result<[User], APIError>) in
            switch result {
            case let .success(users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}


extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        
        if forPreview {
            self.users = User.mockUsers
        }
    }
}
