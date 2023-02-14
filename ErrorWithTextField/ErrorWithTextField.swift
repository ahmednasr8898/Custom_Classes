//
//  ErrorWithTextField.swift
//  ErrorWithTextField
//
//  Created by Ahmed Nasr on 12/02/2023.
//

import UIKit


class ErrorWithTextField: UITextField {
    
    
    //MARK: - private Properties -
    //
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "please enter this field"
        label.textColor = .red
        return label
    }()
    
    //MARK: - Usage Properties -
    //
    var type: TextFieldType? {
        didSet {
            self.errorLabel.text = type?.errorMessage
        }
    }

    var hiddenErrorLabel: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0.4) {
                self.errorLabel.isHidden = self.hiddenErrorLabel
            }
           
        }
    }
    
    //MARK: - init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        textFieldTarget()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        textFieldTarget()
    }
    
    private func setupConstraints() {
        self.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
    }
    
    private func textFieldTarget() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        self.hiddenErrorLabel = true
    }
}


extension ErrorWithTextField {
    enum TextFieldType {
        case phoneNumber
        case password
        
        var errorMessage: String {
            switch self {
            case .phoneNumber:
                return "enter phone number"
            case .password:
                return "enter password"
            }
        }
    }
}
