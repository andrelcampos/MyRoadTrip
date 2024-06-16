//
//  LegDetailsViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import UIKit

class LegDetailsViewController: UIViewController {
    
    var viewModel: LegDetailsViewModel

    init(viewModel: LegDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detahes"
        
        setupUI()
    }
    
    func setupUI() {
        // Titulo
        let titleLabel = UILabel()
        titleLabel.font = TextStyle.title1.font()
        titleLabel.textColor = .mainTxt
        titleLabel.text = viewModel.titleStr
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let labelStrFont = TextStyle.paragraph1
        let labelValueFont = TextStyle.listTitle
        
        // De: <origem>
        let fromLabel = UILabel()
        fromLabel.font = labelStrFont.font()
        fromLabel.textColor = labelStrFont.color
        fromLabel.text = viewModel.fromStr
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromLabel)
        
        let fromLabelValue = UILabel()
        fromLabelValue.font = labelValueFont.font()
        fromLabelValue.textColor = labelValueFont.color
        fromLabelValue.text = viewModel.route.origin
        fromLabelValue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromLabelValue)
        
        // Até: <destino>
        let toLabel = UILabel()
        toLabel.font = labelStrFont.font()
        toLabel.textColor = labelStrFont.color
        toLabel.text = viewModel.toStr
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toLabel)
        
        let toLabelValue = UILabel()
        toLabelValue.font = labelValueFont.font()
        toLabelValue.textColor = labelValueFont.color
        toLabelValue.text = viewModel.route.destination
        toLabelValue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toLabelValue)
        
        // Distância aproximada: <distancia>
        let distanceLabel = UILabel()
        distanceLabel.font = labelStrFont.font()
        distanceLabel.textColor = labelStrFont.color
        distanceLabel.text = viewModel.distanceStr
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distanceLabel)
        
        let distLabelValue = UILabel()
        distLabelValue.font = labelValueFont.font()
        distLabelValue.textColor = labelValueFont.color
        distLabelValue.text = viewModel.route.distance
        distLabelValue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distLabelValue)
        
        // Stack View para botões
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Botão Ver passo a passo
        let stepByStepButton = createButton(withTitle: viewModel.stepByStepBtn)
        stepByStepButton.addTarget(self, action: #selector(stepByStepButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(stepByStepButton)
        
        if viewModel.route.endLocation != nil {
            
            if UIApplication.shared.canOpenURL(URL(string: "https://waze.com/ul")!) {
                // Botão Começar a dirigir
                let startDrivingButton = createButton(withTitle: viewModel.startDrivingBtn)
                startDrivingButton.addTarget(self, action: #selector(startDrivingButtonTapped), for: .touchUpInside)
                stackView.addArrangedSubview(startDrivingButton)
            }
            
            // Botão O que fazer em <destino>
            let whatToDoButton = createButton(withTitle: viewModel.whatToDoBtn)
            whatToDoButton.addTarget(self, action: #selector(whatToDoButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(whatToDoButton)
            
            // Botão Onde me hospedar
            let whereToStayButton = createButton(withTitle: viewModel.whereToStayBtn)
            whereToStayButton.addTarget(self, action: #selector(whereToStayButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(whereToStayButton)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fromLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            fromLabelValue.centerYAnchor.constraint(equalTo: fromLabel.centerYAnchor),
            fromLabelValue.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor, constant: 8),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: fromLabelValue.trailingAnchor, constant: 16),
            
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            toLabelValue.centerYAnchor.constraint(equalTo: toLabel.centerYAnchor),
            toLabelValue.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 8),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: toLabelValue.trailingAnchor, constant: 16),
            
            distanceLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            distLabelValue.centerYAnchor.constraint(equalTo: distanceLabel.centerYAnchor),
            distLabelValue.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 8),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: distLabelValue.trailingAnchor, constant: 16),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    func createButton(withTitle title: String) -> UIButton {
        let style = TextStyle.button1
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = style.font()
        button.setTitleColor(.secondaryTxt, for: .normal)
        button.backgroundColor = style.color
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return button
    }
    
    @objc func stepByStepButtonTapped() {
        viewModel.goToStepsTapped()
    }
    
    @objc func startDrivingButtonTapped() {
        viewModel.goToStartDrivingTapped()
    }
    
    @objc func whatToDoButtonTapped() {
        viewModel.goToWhatToDoTapped()
    }
    
    @objc func whereToStayButtonTapped() {
        viewModel.goToWhereToStayTapped()
    }
}
