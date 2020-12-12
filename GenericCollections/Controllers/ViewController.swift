//
//  ViewController.swift
//  GenericCollections
//
//  Created by Mac on 5.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // --- Temp Data --- //
    let data = [
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
        AuthorModel(name: "Özgür", surname: "Elmaslı", about: "Hi! It's Ozgur. This is generic Collection / TableView example. Thank you! ", date: Date()),
    ]
    
    private var genericCollection : GenericCollectionView<AuthorModel ,AuthorCell>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.setCollectionView()
     
        //MARK:-> DidSelect Basic Call / You can still use RxCocoa funcs
        self.genericCollection?.source?.didSelected = { index in
            print(self.genericCollection?.data?[index].date as Any)
        }
        //MARK:-> Only set data. It's OK. :)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.genericCollection?.data = self.data
        }
    }
}
//MARK:-> setCollectionView
extension ViewController {
    private func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        self.genericCollection = GenericCollectionView<AuthorModel , AuthorCell>(frame: .zero
                                                                                   , collectionViewLayout: flowLayout
                                                                                   , identifier: "identifier")

        self.view.addSubview(self.genericCollection!)
        self.genericCollection?.layoutFillAllToSuperView()
    }
}


