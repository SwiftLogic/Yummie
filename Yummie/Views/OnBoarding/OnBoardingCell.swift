//
//  OnBoardingCell.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/16/21.
//

import UIKit
class OnBoardingCell: UICollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    static let identifier = String(describing: OnBoardingCell.self)
    
    var onboardingSlide: OnboardingSlide? {
        didSet {
            guard let onboardingSlide = onboardingSlide else {return}
            
            imageView.image = onboardingSlide.image
            handleSetUpLabelAttr(withTitle: onboardingSlide.title, andSubTitle: onboardingSlide.description)
            
        }
    }
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: - Handlers
    
    fileprivate func setUpViews() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(titleLabel)
        
        
        let toppadding: CGFloat = UIDevice.current.hasNotch ? 50 : 0

        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: toppadding, left: 0, bottom: 0, right: 0))
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.1).isActive = true
        
        
        
        let padding: CGFloat = UIDevice.current.hasNotch ? 120 : 30
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: padding, right: 20))

        
    }
    
    
    fileprivate func handleSetUpLabelAttr(withTitle title: String, andSubTitle subTitle: String) {
        let attributedString = setupAttributedTextWithFonts(titleString: title, subTitleString: subTitle, attributedTextColor: .lightGray, mainColor: .black, mainfont: UIFont.systemFont(ofSize: 31, weight: .heavy), subFont: UIFont.systemFont(ofSize: 15))
        
        titleLabel.attributedText = attributedString
    }
    
    
    
    //MARK: - Target Selectors
    
}


