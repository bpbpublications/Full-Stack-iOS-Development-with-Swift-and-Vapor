//
//  UserController.swift
//  
//
//  Created by hdutt on 02/07/22.
//

import Foundation
import Vapor

struct User : Content{
    let name : String
    let age : Int
    let address : Address
}

struct Address : Content{
    let street : String
    let state : String
    let zip : String
}

struct UserController : RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        //users Group
        let users = routes.grouped("users")
        
        //Routes
        users.get(use: getAllUsers)
        
        // /user/userId
        users.group(":userId") { user in
            user.get(use: show)
        }
        
        //POST
        users.post("create", use: createUser)
    }
    
    func createUser(request: Request) throws -> HTTPStatus {
        let user = try request.content.decode(User.self)
        print(user)
        return .ok
    }
    
    func show(request: Request) throws -> String {
        guard let userId = request.parameters.get("userId") as String? else {
            throw Abort(.badRequest)
        }
        
        return "Show user for user id = \(userId)"
    }
    
    func getAllUsers(request: Request) throws -> [User] {
        let address = Address(street: "Road 8 Rohini sec 8" , state: "Delhi", zip: "110085")
        let users = [User(name: "User1", age: 32, address: address)]
        return users
    }
}
