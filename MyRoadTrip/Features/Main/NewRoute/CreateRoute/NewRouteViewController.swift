//
//  NewRouteViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation
import UIKit

// MARK: - Class
class NewRouteViewController: UIViewController, UITextFieldDelegate {

    // MARK: Variables
    let viewModel = NewRouteViewModel()
    
    let originLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.body1
        label.font = style.font()
        label.textColor = style.color
        return label
    }()

    let originTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .next
        return textField
    }()

    let destinationLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.body1
        label.font = style.font()
        label.textColor = style.color
        return label
    }()

    let destinationTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .next
        return textField
    }()

    let distanceLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.body1
        label.font = style.font()
        label.textColor = style.color
        return label
    }()

    let distanceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()

    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        let style = TextStyle.button1
        button.titleLabel?.font = style.font()
        button.setTitleColor(.secondaryTxt, for: .normal)
        button.backgroundColor = style.color
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()

    // MARK: Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.strings.navTitle

        setupViews()
        setupConstraints()

        originTextField.delegate = self
        destinationTextField.delegate = self
        distanceTextField.delegate = self

        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        distanceTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.originTextField.text = "Canoas"
        self.destinationTextField.text = "Buenos Aires"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.searchButtonTapped()
        }
    }

    // MARK: Methods
    func setupViews() {
        view.addSubview(originLabel)
        view.addSubview(originTextField)
        view.addSubview(destinationLabel)
        view.addSubview(destinationTextField)
        view.addSubview(distanceLabel)
        view.addSubview(distanceTextField)
        view.addSubview(searchButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    
        let str = viewModel.strings
        
        originLabel.text = str.origStr
        originTextField.placeholder = str.origHolder
        destinationLabel.text = str.destStr
        destinationTextField.placeholder = str.destHolder
        distanceLabel.text = str.distStr
        distanceTextField.text = str.distDefault
        searchButton.setTitle(str.bttTitle, for: .normal)
    }

    func setupConstraints() {
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        originTextField.translatesAutoresizingMaskIntoConstraints = false
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationTextField.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            originLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            originLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            originTextField.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 10),
            originTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            originTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            destinationLabel.topAnchor.constraint(equalTo: originTextField.bottomAnchor, constant: 20),
            destinationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            destinationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            destinationTextField.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 10),
            destinationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            destinationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            distanceLabel.topAnchor.constraint(equalTo: destinationTextField.bottomAnchor, constant: 20),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            distanceTextField.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            distanceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            distanceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            searchButton.topAnchor.constraint(equalTo: distanceTextField.bottomAnchor, constant: 30),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        validateFields()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == originTextField {
            destinationTextField.becomeFirstResponder()
        }
        else if textField == destinationTextField {
            distanceTextField.becomeFirstResponder()
        }
        else {
            view.endEditing(true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == distanceTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        validateFields()
        return true
    }

    func validateFields() {
        guard let originText = originTextField.text, !originText.isEmpty,
              let destinationText = destinationTextField.text, !destinationText.isEmpty,
              let distanceText = distanceTextField.text, let distance = Int(distanceText),
              distance >= 100, distance <= 1000 else {
            setButtonTo(enable: false)
            return
        }
        setButtonTo(enable: true)
    }

    @objc func searchButtonTapped() {
        setLoading(true)
        viewModel.tappedSearch(origin: originTextField.text,
                               destination: destinationTextField.text,
                               dailyDistance: distanceTextField.text) { [weak self] (error)  in
            DispatchQueue.main.async {
                self?.setLoading(false)
                guard let error = error, let self = self else { return }
                
                let alert = UIAlertController(title: "Ocorreu um erro", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Entendi", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        setButtonTo(enable: !isLoading)
    }
    
    func setButtonTo(enable: Bool) {
        searchButton.isEnabled = enable
        searchButton.alpha = enable ? 1.0 : 0.5
    }
}
