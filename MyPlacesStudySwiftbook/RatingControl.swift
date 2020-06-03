//
//  RatingControl.swift
//  MyPlacesStudySwiftbook
//
//  Created by Евгений Скилиоти on 03.06.2020.
//  Copyright © 2020 Евгений Скилиоти. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButton()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButton()
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
//    MAKR: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed 🖖")
    }
    
    
//    MARK: Private Method
    private func setupButton() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
//        create the button
        let button = UIButton()
            button.backgroundColor = .red
                 
            //        add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
                 
            //        setup the vuttin action
                 
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
                 
            //        add the button to stack view
                 
            addArrangedSubview(button)
            //        add the new button on the rating button array
            ratingButtons.append(button)


        }

     
        
        
    }

}
