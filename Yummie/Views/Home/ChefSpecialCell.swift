//
//  ChefSpecialCell.swift
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
class ChefSpecialCell: UICollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUpViews()
//        setUpShadowView()
    }
    
    
    
    
    //MARK: - Properties
    static let identifier = String(describing: ChefSpecialCell.self)
    
    var dish: Dish?{
        didSet {
            guard let dish = dish else {return}
            dishImageView.kf.setImage(with: dish.image?.asUrl)
            titleLabel.text = dish.name
            descriptionLabel.text = dish.description
            caloriesLabel.text = dish.formattedCalories
        }
    }
    
    
    fileprivate let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .left
//        label.text = "Fried Plantain"
        return label
    }()
    
    
     let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)//UIFont.boldSystemFont(ofSize: 13) //14
        label.textAlignment = .left
//        label.text = "Fried plantain is the truth my gee"
        return label
    }()
    
    
    
    fileprivate let caloriesLabel: UILabel = {
        let label = UILabel()
//        label.text = "34"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    
    
    //MARK: - Handlers
    
     func setUpViews() {
        addSubview(dishImageView)
        
        let imageViewPadding: CGFloat = 16
        let imageViewDimen: CGFloat = 68
        
        dishImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: imageViewPadding, left: imageViewPadding, bottom: imageViewPadding, right: 0), size: .init(width: imageViewDimen, height: imageViewDimen))//.init(width: frame.height - 20, height: 0))
        
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, caloriesLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        stackView.anchor(top: dishImageView.topAnchor, leading: dishImageView.trailingAnchor, bottom: dishImageView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 10, bottom: 4, right: 16))
        
        
        dishImageView.backgroundColor = .red
       setUpShadowView()
    }
    
    
    
    func setUpDishListVC() {
        addSubview(dishImageView)
        
        let imageViewPadding: CGFloat = 16
        let imageViewDimen: CGFloat = 55

        dishImageView.centerYInSuperview()
        dishImageView.constrainToLeft(paddingLeft: imageViewPadding)
        dishImageView.constrainHeight(constant: imageViewDimen)
        dishImageView.constrainWidth(constant: imageViewDimen)
        
        
//        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
//        stackView.axis = .vertical
//        stackView.alignment = .top
//        stackView.spacing = 4
//        addSubview(stackView)
//        stackView.anchor(top: dishImageView.topAnchor, leading: dishImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 1, left: 10, bottom: 0, right: 16), size: .init(width: 0, height: 40))
//
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        stackView.anchor(top: dishImageView.topAnchor, leading: dishImageView.trailingAnchor, bottom: dishImageView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 10, bottom: 6, right: 16))
        
        titleLabel.font = UIFont.systemFont(ofSize: 14.5, weight: .semibold)

        setUpShadowView()
    }
    
    
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
