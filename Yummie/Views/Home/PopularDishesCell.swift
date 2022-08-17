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
            caloriesButton.setTitle(dish.formattedCalories, for: .normal)
            
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
    
    
 
    
    fileprivate let caloriesButton: UIButton = {
        let button = UIButton(type: .system)
        let image: UIImage
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .black, scale: .large)
        image = UIImage(systemName: "flame.fill", withConfiguration: config)!
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        let heightDimen: CGFloat = 25
        let widthDimen: CGFloat = 120
        button.constrainWidth(constant: widthDimen)
        button.constrainHeight(constant: heightDimen)
        button.layer.cornerRadius = heightDimen / 2
        button.backgroundColor = .white
        button.frame = CGRect(x: 0, y: 0, width: widthDimen, height: heightDimen)
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: 10).cgPath
        button.tintColor = UIColor.rgb(red: 223, green: 20, blue: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    
    
    
    //MARK: - Handlers
    fileprivate func setUpViews() {
        
        addSubview(titleLabel)
        addSubview(dishImageView)
        addSubview(caloriesButton)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 20))
        
        
        dishImageView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: caloriesButton.topAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
//        dishImageView.contentHuggingPriority(for: .vertical)
        
        caloriesButton.constrainToBottom(paddingBottom: 8)
        caloriesButton.centerXInSuperview()
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
