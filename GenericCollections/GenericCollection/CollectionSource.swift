//
//  CollectionSource.swift
//  GenericCollections
//
//  Created by Mac on 5.12.2020.
//

import Foundation
import UIKit

protocol DataSource {
    var didSelected : ((Int)->())? { get }
    var numberOfSection : Int  { get set }
    var resuseableIdentifier : String { get set }
}

class CollectionViewDataSource<C: UICollectionViewCell & CellConfig , D : Codable> :  NSObject , UICollectionViewDataSource , UICollectionViewDelegate , DataSource {
    
    fileprivate var data : [D]?
    
    var resuseableIdentifier: String
    var didSelected : ((Int)->())?
    var numberOfSection = 1
    //MARK:-> Private
    init(section : Int = 1 , identfier: String) {
        self.numberOfSection = section
        self.resuseableIdentifier = identfier
    }
    
    func setData(data : [D]){
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data {
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.resuseableIdentifier
                                                            , for: indexPath) as? C else {
            fatalError()
        }
        if let item = self.data?[indexPath.row] {
            print(item)
            cell.configure(data: item)
        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSection
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelected?(indexPath.row)
    }
}
