//
//  ViewController.swift
//  GenericCollections
//
//  Created by Mac on 5.12.2020.
//

import UIKit

class ViewControllerViewModel {
    var isLoaded : ()->() = {}
    private(set) var data : [Datum]? = []
    private let serviceProvider = ServiceLayer<ExampleService>()

    func getData(){
        self.serviceProvider.load(service: .getData
                                  , decodeTo: Example.self) { (example) in
            self.data = example.data
            self.isLoaded()
        }
    }
    
}

class ViewController: UIViewController {
    
    private var genericCollection : GenericCollectionView<Datum ,AuthorCell>?
    private let viewModel = ViewControllerViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.setCollectionView()
     
        //MARK:-> DidSelect Basic Call / You can still use RxCocoa funcs
        self.genericCollection?.source?.didSelected = { index in
            print(index)
        }
        //MARK:-> Only set data. It's OK. :)
        self.viewModel.isLoaded = { [weak self] in
            DispatchQueue.main.async {
                    self?.genericCollection?.data = self?.viewModel.data
            }
        }
        
        self.viewModel.getData()
    }
}
//MARK:-> setCollectionView
extension ViewController {
    private func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        self.genericCollection = GenericCollectionView<Datum , AuthorCell>(frame: .zero
                                                                                   , collectionViewLayout: flowLayout
                                                                                   , identifier: "identifier")

        self.view.addSubview(self.genericCollection!)
        self.genericCollection?.layoutFillAllToSuperView()
    }
}


