//
//  Alert.swift
//  Alert
//
//  Created by Ahmed Nasr on 08/02/2023.
//  Copyright © 2023 Ahmed Nasr. All rights reserved.
//

import UIKit

//MARK: - button action -
//
struct ButtonAction {
    let title: String
    let style: UIAlertAction.Style
    var handler: ((UIAlertAction) -> Void)?
}


class Alert {
    
    //MARK: - Private Properties -
    //
    public private(set) var alertTitle: String = "title"
    public private(set) var alertMessage: String = "message"
    public private(set) var alertStyle: UIAlertController.Style = .alert
    public private(set) var buttons: [ButtonAction] = []
    
    
    //MARK: - Builder func -
    //
    func setStyle(_ style: UIAlertController.Style) {
        alertStyle = style
    }
    
    func setTitle(_ text: String) {
        alertTitle = text
    }
    
    func setMessage(_ text: String) {
        alertMessage = text
    }
    
    func setButtonAction(_ action: ButtonAction) {
        buttons.append(action)
    }
    
    func build() -> UIAlertController {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        
        for button in buttons {
            let actionButton = UIAlertAction(title: button.title, style: button.style, handler: button.handler)
            alert.addAction(actionButton)
        }
    
        return alert
    }
}
