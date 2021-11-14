//
//  ViewController.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/13/21.
//

import UIKit

class OnBoardingVC: UIViewController {
    
    
    //MARK: - Init
    

    //MARK: - View's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpNavBar()
    }


    //MARK: - Properties
    var slides: [OnboardingSlide]  = [OnboardingSlide(title: "Delicious Dishes", description: "\nExperience a variety of amazing dishes from different cultures around the world", image: #imageLiteral(resourceName: "slide2")), OnboardingSlide(title: "World-Class Chefs", description: "\nOur dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")), OnboardingSlide(title: "Instant World-Wide Delivery", description: "\nYour orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))]
    
    
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black//UIColor.rgb(red: 73, green: 73, blue: 73)
        button.cornerRadius = 10
        button.addTarget(self, action: #selector(handleDidTapNextButton), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black//red.withAlphaComponent(0.8)
        pageControl.numberOfPages = slides.count
        pageControl.addTarget(self, action: #selector(handleDidTapPageControl), for: .valueChanged)
        return pageControl
    }()
    
    
    //MARK: - Handlers
    fileprivate func setUpViews() {
        view.backgroundColor = .white
        setUpCollectionView()
        
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        
        nextButton.constrainWidth(constant: 150)
        nextButton.constrainHeight(constant: 50)
        nextButton.centerXInSuperview()
        
        
        let padding: CGFloat = UIDevice.current.hasNotch ? 120 : 35

        nextButton.constrainToBottom(paddingBottom: -padding)
        
        pageControl.anchor(top: nil, leading: nextButton.leadingAnchor, bottom: nextButton.topAnchor, trailing: nextButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    
    
    fileprivate func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 120, right: 0))
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.identifier)
        
    }
    
    
    
    fileprivate func setUpNavBar() {
        navigationController?.setNavigationBarBorderColor(.clear) //removes navline
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    
    
    
    fileprivate func handleSetButtonTitle(withIndex index: Int) {
        if index == 0 || index == 1 {
            nextButton.setTitle("Next", for: .normal)
        } else {
            nextButton.setTitle("Get Started", for: .normal)
        }
    }
    
    
    //MARK: - Target Selectors
    @objc fileprivate func handleDidTapPageControl() {
        let indexpath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        handleSetButtonTitle(withIndex: pageControl.currentPage)
    }
    
    
    
    
    @objc fileprivate func handleDidTapNextButton() {
        let currentPage = pageControl.currentPage
        
        if currentPage == 0 || currentPage == 1 {
            pageControl.currentPage += 1
            handleDidTapPageControl()
            
        } else {
            
            let viewController = HomeVC()
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .fullScreen
            navController.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true 
            present(navController, animated: true)
        }
    }
    
    
}


extension OnBoardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.identifier, for: indexPath) as! OnBoardingCell
        cell.onboardingSlide = slides[indexPath.item]
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        pageControl.currentPage = pageNumber
        handleSetButtonTitle(withIndex: pageNumber)
    }
}
