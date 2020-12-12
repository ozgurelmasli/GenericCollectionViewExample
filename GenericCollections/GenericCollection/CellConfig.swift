//
//  CellConfig.swift
//  GenericCollections
//
//  Created by Mac on 6.12.2020.
//

import Foundation
import UIKit

protocol CellConfig {
    func configure<T>(data : T) where T:Codable
}

