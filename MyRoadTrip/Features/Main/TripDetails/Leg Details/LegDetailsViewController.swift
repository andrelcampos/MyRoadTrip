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
        
        let labelFont = TextStyle.body1.font()
        let labelColor = UIColor.mainTxt
        
        // De: <origem>
        let fromLabel = UILabel()
        fromLabel.font = labelFont
        fromLabel.textColor = labelColor
        fromLabel.text = viewModel.fromStr
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromLabel)
        
        // Até: <destino>
        let toLabel = UILabel()
        toLabel.font = labelFont
        toLabel.textColor = labelColor
        toLabel.text = viewModel.toStr
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toLabel)
        
        // Distância aproximada: <distancia>
        let distanceLabel = UILabel()
        distanceLabel.font = labelFont
        distanceLabel.textColor = labelColor
        distanceLabel.text = viewModel.distanceStr
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distanceLabel)
        
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
            // Botão Começar a dirigir
            let startDrivingButton = createButton(withTitle: viewModel.startDrivingBtn)
            startDrivingButton.addTarget(self, action: #selector(startDrivingButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(startDrivingButton)
            
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
            
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            distanceLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
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
        DispatchQueue.main.async {
            self.viewModel.goToStepByStep?(self.viewModel.steps)
        }
    }
    
    @objc func startDrivingButtonTapped() {
        guard let location = viewModel.route.endLocation else { return }
        DispatchQueue.main.async {[location] in
            self.viewModel.goToStartDriving?(location)
        }
    }
    
    @objc func whatToDoButtonTapped() {
        guard let location = viewModel.route.endLocation else { return }
        DispatchQueue.main.async {[location] in
            self.viewModel.goToWhatToDo?(location)
        }
    }
    
    @objc func whereToStayButtonTapped() {
        guard let location = viewModel.route.endLocation else { return }
        DispatchQueue.main.async {[location] in
            self.viewModel.goToWhereToStay?(location)
        }
    }
}
