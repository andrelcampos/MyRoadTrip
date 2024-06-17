//
//  HistoryViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel: HistoryViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Histórico"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Adicionando observador para notificações de novas viagens
        NotificationCenter.default.addObserver(self, selector: #selector(newTripAdded(_:)), name: .newTripAdded, object: nil)
        
        viewModel.fetchTrips()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .newTripAdded, object: nil)
    }
    
    @objc private func newTripAdded(_ notification: Notification) {
        viewModel.fetchTrips()
        tableView.reloadData()
    }
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        let trip = viewModel.trips[indexPath.row]
        cell.configure(with: trip)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openTrip(indexPath, nav: self.navigationController ?? UINavigationController())
    }
}

// Extension to add Notification Name
extension Notification.Name {
    static let newTripAdded = Notification.Name("newTripAdded")
}
