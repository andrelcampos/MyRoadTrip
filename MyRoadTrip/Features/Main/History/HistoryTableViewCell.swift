//
//  HistoryTableViewCell.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
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
    
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.textColor = UIColor(hex: "#033E8C")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor(hex: "#033E8C")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
        cardView.addSubview(fromLabel)
        cardView.addSubview(toLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            fromLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            fromLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            fromLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8),
            toLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            toLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            toLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with trip: TripModel) {
        fromLabel.text = "De: \(trip.origin)"
        toLabel.text = "Para: \(trip.destination)"
    }
}
