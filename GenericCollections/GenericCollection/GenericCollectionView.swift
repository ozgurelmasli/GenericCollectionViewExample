//
//  GenericCollectionView.swift
//  GenericCollections
//
//  Created by Mac on 12.12.2020.
//

import Foundation
import UIKit

class  GenericCollectionView<T : Codable , C : UICollectionViewCell & CellConfig>: UICollectionView {
    open var data : [T]?{
        didSet {
            self.configure()
        }
    }
   private(set) var source : CollectionViewDataSource<C,T>?
    fileprivate func configure(){
        self.register(C.self, forCellWithReuseIdentifier: self.source?.resuseableIdentifier ?? "cell")
        self.delegate = source
        self.dataSource = source
        
        if let data = self.data {
            self.source?.setData(data: data)
            self.reloadData()
        }
    }
    
    convenience init(frame: CGRect
                     , collectionViewLayout layout: UICollectionViewLayout
                     , identifier : String) {
        self.init(frame:frame , collectionViewLayout :layout)
        self.source = CollectionViewDataSource<C,T>(identfier: identifier)
        self.backgroundColor = .clear
    }
}
