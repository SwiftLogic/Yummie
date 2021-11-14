//
//  PopularDishesCollectionView.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/21/21.
//

//
//  CollectionViewCell
//
//  Created by Osaretin Uyigue on 4/29/19.
//  Copyright © 2019 Osaretin Uyigue. All rights reserved.
//

import UIKit
protocol PopularDishesCollectionViewCellDelegate: AnyObject {
    func didSelectDish(dish: Dish)
}
class PopularDishesCollectionViewCell: CategoryCollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUIDetails()
        setUpCollectionView()
    }
    
    
    
    
    //MARK: - Properties
    weak var delegate: PopularDishesCollectionViewCellDelegate?
    
    static let cellIdentifier = String(describing: PopularDishesCollectionViewCell.self)
    
    var popularDishes: [Dish] = [Dish](){
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    
    //MARK: - Handlers
    fileprivate func customizeUIDetails(){
        titleLabel.text = "Popular Dishes"
    }
    
    
    fileprivate func setUpCollectionView() {
        collectionView.register(PopularDishesCell.self, forCellWithReuseIdentifier: PopularDishesCell.identifier)
    }
    
    
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CollectionView Protocols
extension PopularDishesCollectionViewCell {
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCell.identifier, for: indexPath) as! PopularDishesCell
        cell.popularDish = popularDishes[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 180, height: collectionView.frame.height - 20)//.init(width: 180, height: 300) 
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularDishes.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectDish(dish: popularDishes[indexPath.item])
    }
    
}
