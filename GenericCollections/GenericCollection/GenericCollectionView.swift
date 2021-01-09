//
//  GenericCollectionView.swift
//  GenericCollections
//
//  Created by Mac on 12.12.2020.
//

import Foundation
import UIKit


extension UICollectionViewFlowLayout {
    
    convenience init(spacing : CGFloat , scrollDirection : UICollectionView.ScrollDirection , itemsize : CGSize? = nil){
        self.init()
        self.minimumLineSpacing = spacing
        self.scrollDirection = scrollDirection
        if let itemSize = itemsize {self.itemSize = itemSize}
    }
    
}

class GenericCollectionView<T : Codable & GenericCollectionProtocol , C : UICollectionViewCell & CellConfig> : UICollectionView {
    open var maxHeight : ((CGFloat)->())?
    
    open var data : T?{
        didSet {
            if isCollectionHeightDynamic {self.getMaxHeight()}
            self.configure()
        }
    }
   private(set) var source : CollectionViewDataSource<C,T>?
   private var isCollectionHeightDynamic = false
   fileprivate func configure(){
        self.register(C.self, forCellWithReuseIdentifier: self.source?.resuseableIdentifier ?? "cell")
        self.dataSource = source
        
        if let data = self.data {
            self.source?.setData(data: data)
            self.reloadData()
        }
    }
    
    convenience init(frame: CGRect
                     , collectionViewLayout layout: UICollectionViewLayout
                     , identifier : String
                     , isHeightDynamic : Bool) {
        self.init(frame:frame , collectionViewLayout :layout)
        self.source = CollectionViewDataSource<C,T>(identfier: identifier)
        self.isCollectionHeightDynamic = isHeightDynamic
        self.backgroundColor = .clear
    }
}
extension GenericCollectionView {
    fileprivate func getMaxHeight(){
        var maxHeight : CGFloat = 0
        if let data = data as? ExampleUI {
            for (index , item) in data.data.enumerated() {
                let width = (UIScreen.main.bounds.width - 68) / 2
                let height = width * (9 / 16)
                let textHeight = "\(item.employeeName) \(item.employeeAge)".getLabelHeight(width: width
                                                                                           , font: .systemFont(ofSize: 20))
                let salary = item.employeeSalary.getLabelHeight(width: width, font: .systemFont(ofSize: 12))
                let companyString = data.company[index].name + " " + "\(data.company[index].avarageSalary)"
                let id = companyString.getLabelHeight(width: width, font: .systemFont(ofSize: 7))
                let total = height + textHeight + salary + id  + 10
                
                total > maxHeight ? maxHeight = total : print("smaller")
            }
            
            self.maxHeight?(maxHeight)
        }
    }
}
