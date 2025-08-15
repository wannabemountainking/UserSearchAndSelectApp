//
//  UserAPIService.swift
//  UserSearchAndSelectApp
//
//  Created by YoonieMac on 7/22/25.
//

import Foundation


class UserAPIServiceSimulator {
    
    static let shared = UserAPIServiceSimulator()
    
    private init() {}
    
    private let allUsers: [User] = [
        
        User(id: UUID(), name: "김철수"),
        User(id: UUID(), name: "이영희"),
        User(id: UUID(), name: "박민수"),
        User(id: UUID(), name: "최지우"),
        User(id: UUID(), name: "한예슬"),
        User(id: UUID(), name: "김민재"),
        User(id: UUID(), name: "정국"),
        User(id: UUID(), name: "아이유"),
        User(id: UUID(), name: "장원영")
    ]
    
    // get
    func getAllUsers() -> [User] {
        return self.allUsers
    }

    
    // searchUserCode(디스페치 큐로 찾게 하고 찾으면 디스페치 큐로 화면 구성
    func searchUsers(keyword: String, completion: @escaping ([User]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let users = self.allUsers.filter { $0.name.contains(keyword) }
            DispatchQueue.main.async {
                completion(users)
            }
        }
    }
}
