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
    private var imageView : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        self.setImageView()
        self.setTextLabel()
        self.setAboutLabel()
        self.setDateLabel()
        
    }
    private func setImageView() {
        self.imageView = UIImageView()
        self.imageView.backgroundColor = .red
        self.addSubview(self.imageView)
        let width = (UIScreen.main.bounds.width - 68) / 2
        let height = width * (9 / 16)
        self.imageView.setAnchor(leftAnchor: self.leftAnchor
                                 , leftConstant: 0
                                 , rightAnchor: self.rightAnchor
                                 , rigthConstant: 0
                                 , topAnchor: self.topAnchor
                                 , topConstant: 0)
        self.imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    private func setTextLabel(){
        self.nameSurnameLabel = UILabel()
        self.nameSurnameLabel.textColor = .white
        self.nameSurnameLabel.numberOfLines = 0
        self.nameSurnameLabel.textAlignment = .center
        self.nameSurnameLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(self.nameSurnameLabel)
        self.nameSurnameLabel.setAnchor(leftAnchor: self.leftAnchor
                                        , leftConstant: 0
                                        , rightAnchor: self.rightAnchor
                                        , rigthConstant: 0
                                        , topAnchor: self.imageView.bottomAnchor
                                        , topConstant: 0)
    }
    private func setAboutLabel(){
        self.aboutLabel = UILabel()
        self.aboutLabel.textColor = .white
        self.aboutLabel.textAlignment = .center
        self.aboutLabel.numberOfLines = 0
        self.aboutLabel.font = UIFont.systemFont(ofSize: 12)
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
        self.dateLabel.numberOfLines = 0
        self.dateLabel.setAnchor(rightAnchor: self.leftAnchor
                                 , rigthConstant: 0
                                 , topAnchor: self.aboutLabel.bottomAnchor
                                 , topConstant: 5)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure<T>(data: T, row: Int) where T : Decodable, T : Encodable {
        guard let data = data as? ExampleUI else {return}
        let item = data.data[row]
        let company = data.company[row]
        self.nameSurnameLabel.text = item.employeeName  + " " + item.employeeAge
        self.aboutLabel.text = item.employeeSalary
        self.dateLabel.text = company.name + " " + "\(company.avarageSalary)"
    }
    
}
