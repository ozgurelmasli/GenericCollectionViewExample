//
//  exampleCell.swift
//  GenericCollections
//
//  Created by Mac on 6.12.2020.
//

import Foundation
import UIKit

class AuthorCell : UICollectionViewCell  , CellConfig{
    private var nameSurnameLabel : UILabel!
    private var aboutLabel : UILabel!
    private var dateLabel : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemOrange
        self.setTextLabel()
        self.setAboutLabel()
        self.setDateLabel()
    }
    private func setTextLabel(){
        self.nameSurnameLabel = UILabel()
        self.nameSurnameLabel.textColor = .white
        self.nameSurnameLabel.textAlignment = .center
        self.addSubview(self.nameSurnameLabel)
        self.nameSurnameLabel.setAnchor(leftAnchor: self.leftAnchor
                                        , leftConstant: 0
                                        , rightAnchor: self.rightAnchor
                                        , rigthConstant: 0
                                        , topAnchor: self.topAnchor
                                        , topConstant: 0)
    }
    private func setAboutLabel(){
        self.aboutLabel = UILabel()
        self.aboutLabel.textColor = .white
        self.aboutLabel.font = UIFont.systemFont(ofSize: 10)
        self.aboutLabel.textAlignment = .center
        self.aboutLabel.numberOfLines = 0
        self.addSubview(self.aboutLabel)
        self.aboutLabel.setAnchor(leftAnchor: self.leftAnchor
                                        , leftConstant: 0
                                        , rightAnchor: self.rightAnchor
                                        , rigthConstant: 0
                                        , topAnchor: self.nameSurnameLabel.bottomAnchor
                                        , topConstant: 10)
    }
    private func setDateLabel(){
        self.dateLabel = UILabel()
        self.dateLabel.textColor = .white
        self.dateLabel.textAlignment = .center
        self.dateLabel.font = UIFont.systemFont(ofSize: 7)
        self.addSubview(self.dateLabel)
        self.dateLabel.setAnchor(rightAnchor: self.rightAnchor
                                 , rigthConstant: 0
                                 , bottomAnchor: self.bottomAnchor
                                 , bottomConstant: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<T>(data: T) where T : Decodable, T : Encodable {
        //MARK:->Set Data 2 UI
        guard let data = data as? Datum else {return}
        self.nameSurnameLabel.text = data.employeeName  + " " + data.employeeAge
        self.aboutLabel.text = data.employeeSalary
        self.dateLabel.text = data.id
    }
}
