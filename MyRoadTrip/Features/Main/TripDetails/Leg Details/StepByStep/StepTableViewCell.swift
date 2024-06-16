//
//  StepTableViewCell.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import UIKit

class StepTableViewCell: UITableViewCell {
    
    static let identifier = "StepTableViewCell"
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.body1
        label.font = style.font()
        label.textColor = style.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        let style = TextStyle.cardDesc
        label.font = style.font()
        label.textColor = style.color
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(instructionLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            instructionLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 8),
            instructionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            instructionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with step: StepModel) {
        distanceLabel.text = "Distância: \(step.distance)"
        instructionLabel.text = step.instruction
        instructionLabel.isHidden = step.instruction == nil
    }
}
