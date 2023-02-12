//
//  UITextField+ToggleButton.swift
//  Test
//
//  Created by Ahmed Nasr on 12/02/2023.
//

import UIKit


//MARK: - Add password toggle button to text field -
//
extension UITextField {
    
    ///Usage to add password toggle
    ///
    public func addPasswordToggle() {
        //configure text field
        isSecureTextEntry = true
        rightViewMode = .unlessEditing
       
        //configure rigth view
        rightView = createToggleButton()
        rightViewMode = .always
    }
    
    private func createToggleButton() -> UIButton {
        let button = UIButton()
        button.setImage(.eyeFill, for: .normal)
        button.imageView?.tintColor = .blue
        button.imageEdgeInsets = Metrics.imageEdgeInsets
        button.frame = Metrics.imageFrame
        button.addTarget(self, action: #selector(toggleButtonWasTapped), for: .touchUpInside)
        return button
    }
    
    @objc private func toggleButtonWasTapped(_ sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setButtonToggleImage(sender)
    }
    
    private func setButtonToggleImage(_ button: UIButton) {
        switch isSecureTextEntry {
        case true:
            button.setImage(.eyeFill, for: .normal)
        case false:
            button.setImage(.eyeSlashFill, for: .normal)
        }
    }
}


private extension UITextField {
    enum Metrics {
        static let imageEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 16)
        static let imageFrame = CGRect(x: 4, y: 4, width: 20, height: 40)
    }
}


extension UIImage {
    static var eyeFill: UIImage {
        UIImage(systemName: "eye.fill")!
    }
    
    static var eyeSlashFill: UIImage {
        UIImage(systemName: "eye.slash.fill")!
    }
}
