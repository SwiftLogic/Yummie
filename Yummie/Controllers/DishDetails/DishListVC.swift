//
//  DishListVC.swift
//  SamiSays11
//
//  Created by Osaretin Uyigue on 5/05/19.
//  Copyright © 2019 Osaretin Uyigue. All rights reserved.
//

import UIKit
import ProgressHUD
enum DishListVCMode {
    case dishOrderMode
    case dishListMode
}
fileprivate let cellReuseIdentifier = "DishListVCcellReuseIdentifier"
class DishListVC: UIViewController {
    
    //MARK: Init
    
    init(mode: DishListVCMode, category: DishCategory = DishCategory(id: "", name: "", image: "")) {
        self.mode = mode
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = APP_BACKGROUND_COLOR
        setUpViews()
        handleSetUpNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleSetUpNavBarAppearance(navigationController: navigationController)
        navigationController?.navigationBar.layer.shadowOpacity = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if mode == .dishOrderMode {
            handleFetchOrderedDishes()
        }
    }
    
    
    //MARK: - Properties
    let mode: DishListVCMode
    var category: DishCategory
    var dishes = [Dish]()
    var orders = [Order]()
    

    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = APP_BACKGROUND_COLOR
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        collectionView.scrollIndicatorInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        return collectionView
    }()
    
    
    
    //MARK: - Handlers
    fileprivate func setUpViews() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(ChefSpecialCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
    }
    
    
    fileprivate func handleSetUpNavBar() {
        if mode == .dishListMode {
            title = category.name
            handleFetchCategoryDishes()
        } else {
            title = "Orders"
            
        }
    }
    
    
    
    //MARK: - API Call
    fileprivate func handleFetchCategoryDishes() {
        ProgressHUD.show()
        NetworkingService.shared.fetchCategoryDishes(categoryId: category.id ?? "") {[weak self] result in
            switch result {
            
            case .success(let dishes):
                ProgressHUD.dismiss()
                self?.dishes = dishes
                self?.collectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    
    
    fileprivate func handleFetchOrderedDishes() {
        ProgressHUD.show()
        NetworkingService.shared.fetchOrders {[weak self] result in
            switch result {
            case .success(let orders):
                ProgressHUD.dismiss()
                self?.orders = orders
                self?.collectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)

            }
        }
    }
    
}



//MARK: CollectionView Delegates & DataSource
extension DishListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! ChefSpecialCell
        handleSetUpCell(cell: cell, indexPath: indexPath)
        cell.setUpDishListVC()
        return cell
    }
    
    
    fileprivate func handleSetUpCell(cell: ChefSpecialCell, indexPath: IndexPath) {
        if mode == .dishListMode {
            cell.dish = dishes[indexPath.item]
        } else {
            cell.dish = orders[indexPath.item].dish
            cell.descriptionLabel.text = orders[indexPath.item].name ?? ""
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 25, height: 80)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mode == .dishOrderMode ? orders.count : dishes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dish = mode == .dishListMode ? dishes[indexPath.item] : orders[indexPath.item].dish else {return}
        
        let dishDetailsVC = DishDetailsVC(dish: dish)
        navigationController?.pushViewController(dishDetailsVC, animated: true)
        
    }
    
    
    
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tabBarheight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        var offsetVal = scrollView.contentOffset.y / tabBarheight
        if offsetVal > 1 {
            offsetVal = 1
            navigationController?.navigationBar.layer.shadowOpacity = 0.4
        } else {
            navigationController?.navigationBar.layer.shadowOpacity = 0
        }
    }
    
    
}
