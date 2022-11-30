//
//  ExploreVC.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import UIKit
import SnapKit

final class RoutesVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 80
        tableView.setContentHuggingPriority(.required, for: .vertical)
        tableView.setContentCompressionResistancePriority(.required, for: .vertical)
        tableView.verticalScrollIndicatorInsets = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        addSubviews()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            RoutesCell.self,
            forCellReuseIdentifier: RoutesCell.identifier
        )
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: EventNotifications.dataLoaded.name, object: nil)
    }
}

// MARK: Public funcs
extension RoutesVC {
    @objc func goButtonWasTapped() {
        
    }
}

extension RoutesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoutesCell.identifier, for: indexPath) as? RoutesCell,
              let route = ApiManager.routes[safe: indexPath.row]
        else { return UITableViewCell() }
        
        
        
        cell.viewModel = RoutesCell.ViewModel(text: route.attributes.longName, color: route.attributes.color, count: route.stops?.count ?? 0, isLongest: route.stops?.count == ApiManager.longestCount, isShortest: route.stops?.count == ApiManager.shortestCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiManager.routes.count
    }
}

private extension RoutesVC {
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    @objc func reloadTable() {
        tableView.reloadData()
    }
}
