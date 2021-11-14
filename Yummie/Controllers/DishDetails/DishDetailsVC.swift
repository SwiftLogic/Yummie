//
//  DishDetailsVC.swift
//  SamiSays11
//
//  Created by Osaretin Uyigue on 5/05/19.
//  Copyright © 2019 Osaretin Uyigue. All rights reserved.
//

import UIKit
import ProgressHUD
class DishDetailsVC: UIViewController {
    
    //MARK: Init
    init(dish: Dish) {
        self.dish = dish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - View's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        loadDataIntoViews()
    }
    
    
    //MARK: - Properties
    fileprivate let dish: Dish
    
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    fileprivate let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.text = "Fried Plantain"
        return label
    }()
    
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Fried plantain is the truth my gee"
        label.numberOfLines = 0
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
    
    
    fileprivate let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    
    fileprivate let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Place Order", for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.rgb(red: 64, green: 64, blue: 64)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDidTapOrderButton), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Handlers
    fileprivate func setUpViews() {
        
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
            
        scrollView.addSubview(dishImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(caloriesButton)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(orderButton)

        dishImageView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: view.frame.height / 1.7))

        titleLabel.anchor(top: dishImageView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0), size: .init(width: 200, height: 0))


        caloriesButton.anchor(top: titleLabel.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))


        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: caloriesButton.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))


        nameTextField.anchor(top: descriptionLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: caloriesButton.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 45))


        orderButton.anchor(top: nameTextField.bottomAnchor, leading: nameTextField.leadingAnchor, bottom: nil, trailing: nameTextField.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 45))
        
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + estimatedHeightOfLabel(text: dish.description ?? ""))

    }
    
    
    fileprivate func loadDataIntoViews() {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLabel.text = dish.name
        descriptionLabel.text = dish.description
        caloriesButton.setTitle(" " + dish.formattedCalories, for: .normal)
        title = "Order \(dish.name ?? "")"
    }
    
    
    
    
    func estimatedHeightOfLabel(text: String) -> CGFloat {

        let size = CGSize(width: view.frame.width - 16, height: 1000)

        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]

        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height

        return rectangleHeight
    }
    
    
    //MARK: - Target Selectors
    @objc fileprivate func handleDidTapOrderButton() {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            ProgressHUD.showError("Please enter your name")
            return}
        
        ProgressHUD.show("Placing Order...")
        NetworkingService.shared.placeOder(dishId: dish.id ?? "", name: name) { result in
            switch result {
            
            case .success(_):
                ProgressHUD.showSuccess("Your order has been received. 👨‍🍳")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
    }
}



