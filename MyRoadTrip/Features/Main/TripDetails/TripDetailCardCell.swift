//
//  TripDetailCardCell.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 12/06/24.
//

import Foundation
import UIKit

// MARK: - Class
class TripDetailCardCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBg
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let trechoLabel: UILabel = {
        let label = UILabel()
        label.font = TextStyle.cardTitle.font()
        label.textColor = .mainTxt
        return label
    }()
    
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.font = TextStyle.cardDesc.font()
        label.textColor = .mainTxt
        return label
    }()
    
    private let toLabel: UILabel = {
        let label = UILabel()
        label.font = TextStyle.cardDesc.font()
        label.textColor = .mainTxt
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = TextStyle.cardDesc.font()
        label.textColor = .mainTxt
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = TextStyle.cardDesc.font()
        label.textColor = .mainTxt
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(trechoLabel)
        containerView.addSubview(fromLabel)
        containerView.addSubview(toLabel)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(durationLabel)
    }

    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        trechoLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            trechoLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            trechoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            fromLabel.topAnchor.constraint(equalTo: trechoLabel.bottomAnchor, constant: 8),
            fromLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8),
            toLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            distanceLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            durationLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 8),
            durationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            durationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    func configure(for step: Int, route: RouteModel) {
        trechoLabel.text = "Trecho \(step)"
        fromLabel.text = "De: " + "\(route.origin)"
        toLabel.text = "Até: \(route.destination)"
        distanceLabel.text = "Distância: \(route.distance)"
        durationLabel.text = "Duração: \(route.duration)"
    }
}

