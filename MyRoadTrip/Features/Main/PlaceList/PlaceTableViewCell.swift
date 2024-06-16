//
//  PlaceTableViewCell.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    static let identifier = "PlaceTableViewCell"
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.cardTitle2
        label.font = style.font()
        label.textColor = style.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.cardDesc
        label.font = style.font()
        label.textColor = style.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.cardDesc
        label.font = style.font()
        label.textColor = style.color
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.cardDesc
        label.font = style.font()
        label.textColor = style.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let siteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver Site", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(UIColor(hex: "#033E8C"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Saiba mais", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(UIColor(hex: "#033E8C"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dirigir", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(UIColor(hex: "#033E8C"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(ratingLabel)
        cardView.addSubview(addressLabel)
        cardView.addSubview(phoneLabel)
        cardView.addSubview(siteButton)
        cardView.addSubview(moreInfoButton)
        cardView.addSubview(navigateButton)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            addressLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            siteButton.topAnchor.constraint(greaterThanOrEqualTo: phoneLabel.bottomAnchor, constant: 8),
            siteButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            
            moreInfoButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            moreInfoButton.leadingAnchor.constraint(equalTo: siteButton.trailingAnchor, constant: 16),
            
            navigateButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            navigateButton.leadingAnchor.constraint(equalTo: moreInfoButton.trailingAnchor, constant: 16),
            navigateButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            navigateButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with place: Place, siteAction: StringVoid?, googleAction: StringVoid?, driveAction: LocationVoid?) {
        nameLabel.text = place.displayName.text
        ratingLabel.text = "Nota: \(place.rating)"
        addressLabel.text = place.shortFormattedAddress.isEmpty ? place.shortFormattedAddress : place.formattedAddress
        let phone = place.nationalPhoneNumber ?? place.internationalPhoneNumber
        phoneLabel.text = phone
        phoneLabel.isHidden = phone == nil
        
        siteButton.isHidden = place.websiteUri == nil
        let goToSite = UIAction { action in
            siteAction?(place.websiteUri ?? "")
        }
        
        siteButton.addAction(goToSite, for: .touchUpInside)
        
        moreInfoButton.addAction(UIAction{ _ in googleAction?(place.googleMapsUri) }, for: .touchUpInside)
        navigateButton.addAction(UIAction{ _ in driveAction?(place.location)}, for: .touchUpInside)
    }
}
