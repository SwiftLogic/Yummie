//
//  HomeFeedCell.swift
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

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    
    
    
    //MARK: - Properties
    var didSelectItem:((DishCategory)-> Void)?
    
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    var dishCategories = [DishCategory]() {
        didSet {
            collectionView.reloadData()
        }
    }

     let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Food Category"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()  
    
    
     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = APP_BACKGROUND_COLOR
        collectionView.contentInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    
    //MARK: - Handlers
     func setUpViews() {
        backgroundColor = APP_BACKGROUND_COLOR
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.constrainToTop(paddingTop: 0)
        titleLabel.constrainToLeft(paddingLeft: 15)
        
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 8, right: 0), size: .init(width: 0, height: 0))
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: FoodCategoryCell.identifier)
    }
    
    
    
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - CollectionView Delegate & Datasource
extension CategoryCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCell.identifier, for: indexPath) as! FoodCategoryCell
        cell.dishCategory = dishCategories[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: 60) //70 //w 150 h56
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishCategories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(dishCategories[indexPath.row])
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            
            let openOption = UIAction(title: "Open",
                                      image: UIImage(systemName: "link"),
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
                print("tapped open")
            }
            
            
            let favoriteOption = UIAction(title: "Favorite",
                                      image: UIImage(systemName: "star"),
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
                print("tapped favoriteOption")
            }
            
            
            let shareOption = UIAction(title: "Share",
                                      image: UIImage(systemName: "square.and.arrow.up"),
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
                print("tapped favoriteOption")
            }
            
            
            let orderOption = UIAction(title: "Order",
                                      image: UIImage(systemName: "cart"),
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
                print("tapped bookmarkOption")
            }
            
            
            let deleteOption = UIAction(title: "Delete",
                                      image: UIImage(systemName: "trash"),
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
                print("tapped deleteOption")
            }
            
            return UIMenu(title: "",
                          image: nil,
                          identifier: nil,
                          options: .displayInline,
                          children: [openOption, orderOption, favoriteOption, shareOption, deleteOption])
        }
        
        return config
    }
    
    
}
