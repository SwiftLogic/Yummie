//
//  ChefSpecialCollectionViewCell.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/22/21.
//

//
//  CollectionViewCell
//
//  Created by Osaretin Uyigue on 4/29/19.
//  Copyright © 2019 Osaretin Uyigue. All rights reserved.
//

import UIKit
class ChefSpecialCollectionViewCell: CategoryCollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUIDetails()
        setUpCollectionView()
    }
    
    
    
    
    //MARK: - Properties
    static let cellIdentifier = String(describing: ChefSpecialCollectionViewCell.self)
    
    weak var delegate: PopularDishesCollectionViewCellDelegate?

    
     var chefSpecials = [Dish]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    //MARK: - Handlers
    
    fileprivate func customizeUIDetails(){
        titleLabel.text = "Chef's Special"
    }
    
    fileprivate func setUpCollectionView() {
        collectionView.register(ChefSpecialCell.self, forCellWithReuseIdentifier: ChefSpecialCell.identifier)
    }
    
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - CollectionView Protocols
extension ChefSpecialCollectionViewCell {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefSpecialCell.identifier, for: indexPath) as! ChefSpecialCell
        cell.setUpViews()
        cell.dish = chefSpecials[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: frame.width - 50, height: collectionView.frame.height - 20)
        return .init(width: frame.width - 50, height: 100) //width : 330

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chefSpecials.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       delegate?.didSelectDish(dish: chefSpecials[indexPath.item])
   }
}
