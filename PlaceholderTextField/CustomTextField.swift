//
//  CustomTextField.swift
//  Test
//
//  Created by Ahmed Nasr on 12/02/2023.
//

import UIKit


@IBDesignable
class CustomTextField: UITextField {
    
    
    //MARK: - private Properties -
    //
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private var textFieldValue: String = ""
    private var placeholderIsOpen = false
    private var centerYTextLabelConstraint: NSLayoutConstraint?
    private var bottomTextLabelConstraint: NSLayoutConstraint?
    
    
    ///Usage to change text field placeholder
    @IBInspectable
    var textPlaceholder: String = "" {
        didSet {
            self.placeholderLabel.text = textPlaceholder
            self.placeholder = ""
        }
    }
    
    
    //MARK: - init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        textFieldTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConstraints()
        textFieldTargets()
    }
    
    private func setConstraints() {
        self.addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        placeholderLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setCenterYConstraints()
    }
    
    private func setCenterYConstraints() {
        self.centerYTextLabelConstraint = placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.centerYTextLabelConstraint?.isActive = true
    }
    
    private func setBottomConstraints() {
        self.bottomTextLabelConstraint = self.placeholderLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        self.bottomTextLabelConstraint?.isActive = true
    }
    
    private func textFieldTargets() {
        self.addTarget(self, action: #selector(textFieldEditingEditingChanged), for: .editingChanged)
        self.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    @objc private func textFieldEditingEditingChanged(_ sender: UITextField) {
        self.textFieldValue = sender.text ?? ""
    }
    
    @objc private func textFieldEditingDidBegin() {
        guard !placeholderIsOpen else { return }
        self.centerYTextLabelConstraint?.isActive = false
        setBottomConstraints()
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
        self.placeholderIsOpen = true
    }
    
    @objc private func textFieldEditingDidEnd() {
        guard textFieldValue.isEmpty else { return }
        self.bottomTextLabelConstraint?.isActive = false
        setCenterYConstraints()
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
        self.placeholderIsOpen = false
    }
}
