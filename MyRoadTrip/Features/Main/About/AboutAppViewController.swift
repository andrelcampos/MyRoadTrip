//
//  AboutAppViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation
import UIKit

class AboutAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()

    let sections = ["Informações Pessoais", "Motivação para o App", "O que Esperar"]
    let data = [
        ["Nome: André Leandro de campos", "Email: andreleo.campos@gmail.com", "https://www.linkedin.com/in/andreleocampos/"],
        ["Este aplicativo foi desenvolvido como parte do meu TCC em Engenharia de Software. O objetivo é criar uma ferramenta prática e eficiente para planejar viagens de estrada, utilizando inteligência artificial para personalizar roteiros de acordo com as preferências dos usuários."],
        ["Ao utilizar este aplicativo, você pode esperar sugestões de rotas personalizadas, pontos turísticos interessantes, locais para descanso e muito mais, tudo baseado nas suas preferências e informações fornecidas. Espero que você aproveite suas viagens de estrada de maneira mais organizada e prazerosa!"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sobre o App"
        
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkCell")
    }

    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath) as! LinkTableViewCell
            cell.linkLabel.text = data[indexPath.section][indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data[indexPath.section][indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = .darkGray
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

