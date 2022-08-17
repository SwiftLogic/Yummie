//
//  HomeVC.swift
//  SamiSays11
//
//  Created by Osaretin Uyigue on 5/05/19.
//  Copyright © 2019 Osaretin Uyigue. All rights reserved.
//

import UIKit
import ProgressHUD
class HomeVC: UIViewController {
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        setUpNavBar()
        handleFetchData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleSetUpNavBarAppearance(navigationController: navigationController)
        navigationController?.navigationBar.layer.shadowOpacity = 0
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.layer.shadowOpacity = 0

    }
    //MARK: - Properties
   
    
   fileprivate  var categories: [DishCategory] = [
//        .init(id: "id1", name: "African Dishes", image: "https://picsum.photos/100/200"),
//        .init(id: "id2", name: "American Dishes", image: "https://picsum.photos/100/200"),
//        .init(id: "id3", name: "Italian Dishes", image: "https://picsum.photos/100/200"),
//        .init(id: "id4", name: "Mexican Cuisines", image: "https://picsum.photos/100/200"),
//        .init(id: "id5", name: "European Dishes", image: "https://picsum.photos/100/200"),
//        .init(id: "id6", name: "Korean Dishes", image: "https://picsum.photos/100/200"),
//        .init(id: "id7", name: "Japanese Cuisines", image: "https://picsum.photos/100/200")

    ]
    
    
    
    fileprivate  var popularDishes: [Dish] = [
//        .init(id: "id1", name: "Garri", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34),
//        .init(id: "id2", name: "Indomie", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 11),
//        .init(id: "id3", name: "Pizza", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 78),
//        .init(id: "id4", name: "Spaghetti", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 28)
    ]
    
    fileprivate  var chefSpecials: [Dish] = [
//        .init(id: "id1", name: "Fried Plantain", description: "This is one of chef osa's fav dishes.", image: "https://picsum.photos/100/200", calories: 34),
//        
//        .init(id: "id2", name: "Amala & Ewedu", description: "This is the best yoruba food you'll ever taste", image: "https://picsum.photos/100/200", calories: 11),
//        
//        .init(id: "id3", name: "Pounded Yam & Egusi", description: "One you have to try!", image: "https://picsum.photos/100/200", calories: 78)
    ]
    
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = APP_BACKGROUND_COLOR
        collectionView.contentInset = .init(top: 12, left: 0, bottom: 12, right: 12)
        collectionView.scrollIndicatorInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
        collectionView.showsVerticalScrollIndicator = false 
        return collectionView
    }()
    
    
    fileprivate lazy var cartsButton: UIButton = {
        let button = UIButton(type: .system)
        let image: UIImage
        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .black, scale: .large)
        image = UIImage(systemName: "cart.circle.fill", withConfiguration: config)!
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        let dimen: CGFloat = 32//35
        button.constrainWidth(constant: dimen)
        button.constrainHeight(constant: dimen)
        button.layer.cornerRadius = 27 / 2//dimen / 2
        button.addTarget(self, action: #selector(handleDidTapRightNavItem), for: .touchUpInside)
        button.backgroundColor = .white
        button.frame = CGRect(x: 0, y: 0, width: dimen, height: dimen)
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: 10).cgPath
        button.tintColor = UIColor.rgb(red: 223, green: 20, blue: 0)
        return button
    }()
    
    
    
    //MARK: - Handlers
    fileprivate func setUpViews() {
        view.backgroundColor = APP_BACKGROUND_COLOR
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(PopularDishesCollectionViewCell.self, forCellWithReuseIdentifier: PopularDishesCollectionViewCell.cellIdentifier)
        collectionView.register(ChefSpecialCollectionViewCell.self, forCellWithReuseIdentifier: ChefSpecialCollectionViewCell.cellIdentifier)
        collectionView.alwaysBounceVertical = true 

    }
    
    
    fileprivate func setUpNavBar() {
        navigationItem.title = "Yummie"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartsButton)
        navigationController?.setNavigationBarBorderColor(.clear) //removes navline
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = .white

    }
    
    
    
    fileprivate func didSelectDishCategory(category: DishCategory) {
        let dishListVC = DishListVC(mode: .dishListMode, category: category)
        navigationController?.pushViewController(dishListVC, animated: true)

    }
    
    @objc  fileprivate func handleDidTapRightNavItem() {
        let dishListVC = DishListVC(mode: .dishOrderMode)
        navigationController?.pushViewController(dishListVC, animated: true)
        
    }
    
    
    
    fileprivate func handleFetchData() {
        ProgressHUD.show()
        NetworkingService.shared.fetchAllCategories { [weak self] result in
            
            switch result {
            case .success(let allDishes):
                ProgressHUD.dismiss()
                //update data
                self?.categories = allDishes.categories ?? []
                self?.popularDishes = allDishes.populars ?? []
                self?.chefSpecials = allDishes.specials ?? []
                self?.collectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}



//MARK: - CollectionView Delegate & Datasource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.dishCategories = categories
            
            cell.didSelectItem = {[weak self] category in
                self?.didSelectDishCategory(category: category)
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCollectionViewCell.cellIdentifier, for: indexPath) as! PopularDishesCollectionViewCell
            cell.popularDishes = popularDishes
            cell.delegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefSpecialCollectionViewCell.cellIdentifier, for: indexPath) as! ChefSpecialCollectionViewCell
        cell.chefSpecials = chefSpecials
        cell.delegate = self
        return cell
    }
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return .init(width: view.frame.width, height: 200)
        } else if indexPath.section == 1 {
            return .init(width: view.frame.width, height: 400)
        } else {
            return .init(width: view.frame.width, height: 160)
        }
               
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
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



//MARK: - PopularDishesCollectionViewCellDelegate
extension HomeVC: PopularDishesCollectionViewCellDelegate {
    func didSelectDish(dish: Dish) {
        let dishDetailsVC = DishDetailsVC(dish: dish)
        navigationController?.pushViewController(dishDetailsVC, animated: true)
    }
}
