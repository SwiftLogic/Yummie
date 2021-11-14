//
//  FoodCategoryCell.swift
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
import Kingfisher
class FoodCategoryCell: UICollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpShadowView()
    }
    
    
    
    
    //MARK: - Properties
    static let identifier = String(describing: FoodCategoryCell.self)
    
    var dishCategory: DishCategory? {
        didSet {
            guard let dishCategory = dishCategory else {return}
            imageView.kf.setImage(with: dishCategory.image?.asUrl)
            titleLabel.text = dishCategory.name
            
        }
    }
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "African Dish"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    
    
    
    //MARK: - Handlers
    
    fileprivate func setUpViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.centerYInSuperview()
        imageView.constrainHeight(constant: 50)
        imageView.constrainWidth(constant: 40)
        imageView.constrainToLeft(paddingLeft: 5)
        
        titleLabel.centerYInSuperview()
        titleLabel.anchor(top: nil, leading: imageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    
    
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
