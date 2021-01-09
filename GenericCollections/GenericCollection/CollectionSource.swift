//
//  CollectionSource.swift
//  GenericCollections
//
//  Created by Mac on 5.12.2020.
//

import Foundation
import UIKit

protocol DataSource {
    var numberOfSection : Int  { get set }
    var resuseableIdentifier : String { get set }
}

class CollectionViewDataSource<C: UICollectionViewCell & CellConfig , D : Codable & GenericCollectionProtocol> :  NSObject , UICollectionViewDataSource, DataSource {
    
    fileprivate var data : D?
    
    var resuseableIdentifier: String
    var numberOfSection = 1
    //MARK:-> Private
    init(section : Int = 1 , identfier: String) {
        self.numberOfSection = section
        self.resuseableIdentifier = identfier
    }
    
    func setData(data : D){
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data {
            return data.numberOfItems()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.resuseableIdentifier
                                                            , for: indexPath) as? C else {
            fatalError()
        }
        cell.configure(data: self.data , row: indexPath.row)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSection
    }
}
extension String {
    func getLabelHeight(width : CGFloat , font : UIFont) ->CGFloat{
           let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
           tempLabel.numberOfLines = 0
           tempLabel.text = self
           tempLabel.font = font
           tempLabel.sizeToFit()
           return tempLabel.frame.height
       }
}
