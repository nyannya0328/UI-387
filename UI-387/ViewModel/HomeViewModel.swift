//
//  HomeViewModel.swift
//  UI-387
//
//  Created by nyannyan0328 on 2021/12/09.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var fetched_user : [User] = []
    @Published var dispalying_user :[User]?
    
    init() {
        
        fetched_user = [
           User(profilePick: "User1"),
           User(profilePick: "User2"),
           User(profilePick: "User3"),
           User(profilePick: "User4"),
           User(profilePick: "User5"),
           User(profilePick: "User6"),
       
        
        ]
        
        dispalying_user = fetched_user
        
    }
    
    func getIndex(user : User)->Int{
        
        let index = dispalying_user?.firstIndex(where: { currentuser in
            
            currentuser.id == user.id
        }) ?? 0
        
        return index
        
        
    }
    
    
    
}

