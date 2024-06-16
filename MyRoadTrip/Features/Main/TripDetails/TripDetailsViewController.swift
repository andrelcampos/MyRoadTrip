//
//  TripDetailsViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation
import UIKit

// MARK: - Class
class TripDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Variables
    let viewModel: TripDetailsViewModel
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TripDetailCardCell.self, forCellReuseIdentifier: "TripDetailCardCell")
        return tableView
    }()

    // MARK: Initializers
    init(viewModel: TripDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if let navbar = navigationController?.navigationBar {
            let tabbarAppearance = navbar.standardAppearance
            tabbarAppearance.configureWithOpaqueBackground()
            tabbarAppearance.backgroundColor = .white
            navbar.scrollEdgeAppearance = tabbarAppearance
            navbar.standardAppearance = tabbarAppearance
        }
        
        setupTableView()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = tableView.tableHeaderView {

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }

    // MARK: Methods
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
    }

    func createTableHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let cardView = UIView()
        cardView.backgroundColor = .secondaryBg
        cardView.layer.cornerRadius = 8
        
        headerView.addSubview(cardView)
        
        let headerLabel = UILabel()
        headerLabel.text = viewModel.headerTitle
        headerLabel.textColor = .mainTxt
        headerLabel.font = TextStyle.listTitle.font()
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center

        cardView.addSubview(headerLabel)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            headerLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            cardView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            
            headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])

        return headerView
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.routes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripDetailCardCell", for: indexPath) as! TripDetailCardCell
        let step = indexPath.row + 1
        guard let detail = viewModel.routes[step] else { return cell }
        cell.configure(for: step, route: detail)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let step = indexPath.row + 1
        guard let route = viewModel.routes[step] else { return }
        viewModel.goToRouteDetails?((route, step))
    }
}
