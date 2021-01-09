//
//  EampleModel.swift
//  GenericCollections
//
//  Created by Mac on 15.12.2020.
//

import Foundation

protocol GenericCollectionProtocol {
    func numberOfItems()->Int
}

// MARK: - Example
struct Example: Codable , Hashable {
    let status: String
    let data: [Datum]
}
// MARK: - Datum
struct Datum: Codable , Hashable {
    let id, employeeName, employeeSalary, employeeAge: String
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
struct CompanyUI : Codable , GenericCollectionProtocol {
    let data : [Company]
    func numberOfItems() -> Int {
        return self.data.count
    }
}
// MARK: Company
struct Company : Codable {
    let id , name : String
    let avarageSalary : Int
}
// MARK : UI
struct ExampleUI : Codable , GenericCollectionProtocol {
    let data : [Datum]
    let company : [Company]
    
    func numberOfItems() -> Int {
        return data.count
    }
}
