//
//  WellcomeViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 10/06/24.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - UI Elements
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.mainTxt.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "PathFinder"
        let style = TextStyle.title1
        label.font = style.font()
        label.textColor = style.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo ao PathFinder! \nPlaneje sua road trip de maneira simples e eficiente.\n\n"
        let style = TextStyle.body1
        label.font = style.font()
        label.textColor = style.color
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Vamos lá!", for: .normal)
        let style = TextStyle.button1
        button.titleLabel?.font = style.font()
        button.setTitleColor(.secondaryTxt, for: .normal)
        button.backgroundColor = style.color
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Constraints
    private var appIconCenterYConstraint: NSLayoutConstraint!
    private var appIconWidthConstraint: NSLayoutConstraint!
    private var appIconHeightConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryBg
        setupLayout()
        animateIcon()
    }

    // MARK: - Layout Setup
    private func setupLayout() {
        view.addSubview(appIconImageView)
        view.addSubview(appNameLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(startButton)

        appIconImageView.alpha = 0
        appIconCenterYConstraint = appIconImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        appIconWidthConstraint = appIconImageView.widthAnchor.constraint(equalToConstant: 200)
        appIconHeightConstraint = appIconImageView.heightAnchor.constraint(equalToConstant: 200)

        NSLayoutConstraint.activate([
            // App Icon initial position
            appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIconCenterYConstraint,
            appIconWidthConstraint,
            appIconHeightConstraint,

            // App Name Label
            appNameLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 40),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Welcome Label
            welcomeLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 40),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Start Button
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Animation
    private func animateIcon() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            self.appIconCenterYConstraint.constant = -self.view.frame.height / 2 + 100
            self.appIconWidthConstraint.constant = 100
            self.appIconHeightConstraint.constant = 100
            self.appIconImageView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - Actions
    @objc private func startButtonTapped() {
        self.dismiss(animated: true)
    }
}
