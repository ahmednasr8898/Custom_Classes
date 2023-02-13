//
//  RateView.swift
//  RateStars
//
//  Created by Ahmed Nasr on 09/02/2023.
//

import UIKit


class RateView: UIView {
    
    //MARK: - Private Properties -
    //
    private var starsCount: Int = 5
    private var selectedRate: Int = 0
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    private var rate: Int = 0 {
        didSet {
            if rate <= starsCount {
                fillStars()
            } else {
                rate = starsCount
                fillStars()
            }
            self.selectedRate = rate
        }
    }
    
    private lazy var starsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        /// Adding a UITapGestureRecognizer to our stack of stars to handle clicking on a star
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rateWasTapped))
        stackView.addGestureRecognizer(tapGesture)
        
        return stackView
    }()
    
    //MARK: - Public Usage Functions -
    //
    func setRate(_ rate: Int) {
        self.rate = rate
    }
    
    func getRate() -> Int {
        return selectedRate
    }
    
    //MARK: - init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        createStars()
        fillStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        createStars()
        fillStars()
    }
    
    //MARK: - Private Functions -
    //
    private func setupConstraints() {
        self.addSubview(starsContainer)
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        starsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        starsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        starsContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        starsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
    }
    
    @objc private func rateWasTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsContainer)
        let starWidth = starsContainer.bounds.width / CGFloat(starsCount)
        let rate = Int(location.x / starWidth) + 1
        
        /// if current star doesn't match selectedRate then we change our rating
        if rate != self.selectedRate {
            feedbackGenerator.selectionChanged()
            self.selectedRate = rate
        }
        
        /// loop through starsContainer arrangedSubviews and
        /// look for all Subviews of type UIImageView and change
        /// their isHighlighted state (icons depend on it)
        starsContainer.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
        }
    }
    
    private func fillStars() {
        for i in 0..<rate {
            guard let imageview = starsContainer.arrangedSubviews[i] as? UIImageView else { return }
            imageview.isHighlighted = imageview.tag <= rate
        }
    }
    
    private func createStars() {
        /// loop through the number of our stars and add them to the stackView (starsContainer)
        for index in 1...starsCount {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }
    
    private func makeStarIcon() -> UIImageView {
        /// declare default icon and highlightedImage
        let imageView = UIImageView(image: StarImages.star.image, highlightedImage: StarImages.starFill.image)
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }
}

//MARK: - star images -
//
private enum StarImages: String {
    case star
    case starFill = "star.fill"
    case starFillLeft = "star.fill.left"
    
    var image: UIImage {
        return UIImage(systemName: self.rawValue) ?? UIImage()
    }
}
