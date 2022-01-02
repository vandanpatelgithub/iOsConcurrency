//
//  UsersListViewModel.swift
//  iOSConcurrency (iOS)
//
//  Created by Vandankumar Patel on 12/30/21.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    func fetchUsers() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            apiService.getJSON { (result: Result<[User], APIError>) in
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                case let .success(users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
                    }
                }
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
