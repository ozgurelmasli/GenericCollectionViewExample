//
//  ViewController.swift
//  GenericCollections
//
//  Created by Mac on 5.12.2020.
//

import UIKit

class ViewControllerViewModel {
    var isLoaded : ()->() = {}
    private(set) var data : ExampleUI?
    private let serviceProvider = ServiceLayer<ExampleService>()

    func getData(){
        self.serviceProvider.load(service: .getData
                                  , decodeTo: Example.self) { (example) in
            
            var exampleCompanyArray : [Company] = []
            for (index , item) in example.data.enumerated() {
                exampleCompanyArray.append(Company(id: item.id
                                                   , name: "Random Company -> \(index)"
                                                   , avarageSalary: 200 * index))
            }
            self.data = ExampleUI(data: example.data
                                  , company: exampleCompanyArray)
            self.isLoaded()
        }
    }
    
}

class ViewController: UIViewController {
    
    private var genericCollection : GenericCollectionView<ExampleUI ,AuthorCell>?
    private var height : NSLayoutConstraint?
    private let viewModel = ViewControllerViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.setCollectionView()
    
        //MARK:-> Only set data. It's OK. :)
        self.viewModel.isLoaded = {
            DispatchQueue.main.async {
                self.genericCollection?.data = self.viewModel.data
            }
        }
        self.genericCollection?.maxHeight = { val in
            DispatchQueue.main.async {
                print(val)
                self.height?.constant = val
                self.view.layoutIfNeeded()
            }
        }
        
        self.viewModel.getData()
    }
}
//MARK:-> setCollectionView
extension ViewController {
    private func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        self.genericCollection = GenericCollectionView<ExampleUI, AuthorCell>(frame: .zero
                                                                                   , collectionViewLayout: flowLayout
                                                                              , identifier: "identifier"
                                                                              , isHeightDynamic: true)
        self.genericCollection?.delegate  = self
        self.view.addSubview(self.genericCollection!)
        
        self.genericCollection?.translatesAutoresizingMaskIntoConstraints = false
        self.genericCollection?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.genericCollection?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.genericCollection?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.height = self.genericCollection?.heightAnchor.constraint(equalToConstant: 0)
        
        self.height?.isActive = true
        
    }
}

// UI Delegate
extension ViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let datum = self.viewModel.data?.data[indexPath.row] , let company = self.viewModel.data?.company[indexPath.row] else {return .zero}
        let width = (UIScreen.main.bounds.width - 68) / 2
        let height = width * (9 / 16)
        let text = "\(datum.employeeName) \(datum.employeeAge)"
        let textHeight = text.getLabelHeight(width: width, font: .systemFont(ofSize: 20))
        let salary = datum.employeeSalary.getLabelHeight(width: width, font: .systemFont(ofSize: 12))
        
        let companyString = company.name + " " + "\(company.avarageSalary)"
        let id = companyString.getLabelHeight(width: width, font: .systemFont(ofSize: 7))
        
        return CGSize(width: width
                      , height: height + textHeight + salary + id)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected -> \(String(describing: self.viewModel.data?.data[indexPath.row].employeeAge))")
    }
}

