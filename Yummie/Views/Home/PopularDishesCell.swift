//
//  PopularDishesCell.swift
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
class PopularDishesCell: UICollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpShadowView()
    }
    
    
    
    
    //MARK: - Properties
    var popularDish: Dish? {
        didSet {
            guard let dish = popularDish else {return}
            dishImageView.kf.setImage(with: dish.image?.asUrl)
            titleLabel.text = dish.name
            descriptionLabel.text = dish.description
            caloriesLabel.text = dish.formattedCalories
            
        }
    }
    static let identifier = String(describing: PopularDishesCell.self)
    
    fileprivate let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    
    
    fileprivate let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "34.838383"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    
    
    //MARK: - Handlers
    
    fileprivate func setUpViews() {
        
        addSubview(titleLabel)
        addSubview(dishImageView)
        addSubview(descriptionLabel)
        addSubview(caloriesLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 20))
        
        
        dishImageView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: caloriesLabel.topAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
//        dishImageView.contentHuggingPriority(for: .vertical)

        
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 8, right: 8))
        
        
        caloriesLabel.anchor(top: nil, leading: descriptionLabel.leadingAnchor, bottom: descriptionLabel.topAnchor, trailing: descriptionLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
    }
    
    
    
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
