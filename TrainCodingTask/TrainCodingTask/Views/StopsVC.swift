//
//  StatsVC.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import UIKit
import SnapKit

final class StopsVC: UIViewController {
    
    private var selectedStopsIndex: [Int] = [] {
        didSet {
            showGoButtonIfNeeded()
        }
    }
    
    private lazy var goButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark")!, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(goButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 80
        tableView.setContentHuggingPriority(.required, for: .vertical)
        tableView.setContentCompressionResistancePriority(.required, for: .vertical)
        tableView.verticalScrollIndicatorInsets = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.allowsMultipleSelection = true
        
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
            StopsCell.self,
            forCellReuseIdentifier: StopsCell.identifier
        )
        reloadTable()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: EventNotifications.dataLoaded.name, object: nil)
        
    }
}

// MARK: Public funcs
extension StopsVC {
    @objc func goButtonWasTapped() {
        /// I'm sure there's a more elegant solution complexity wise. Maybe sorting the data in a seperate array in the ApiManager as it comes in.
        /// I'm used to thinking about data that changes live so this makes more sense to me.
        let routes = selectedStopsIndex.compactMap({ ApiManager.multiRouteStops[safe: $0]?.1 })
            .flatMap { $0 }
            .reduce(into: [:]) { count, stop in count[stop, default: 0] += 1 }
            .filter{$0.1 > 1}
        let outputText = routes.count > 1 ? String(format: "%@\n %@", arguments: Array(routes.keys)) : routes.keys.first ?? ""
        var resultsMessage = UIAlertController(title: "Confirm", message: outputText, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> () in })
        resultsMessage.addAction(ok)
        present(resultsMessage, animated: true, completion: nil)
    }
}

extension StopsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StopsCell else
        { return }
        
        cell.selectCell()
        if selectedStopsIndex.count >= 2 {
            if let previousFirst = selectedStopsIndex.first,
               let deselectCell = tableView.cellForRow(at: IndexPath(row: previousFirst, section: 0)) as? StopsCell{
                deselectCell.deselectCell()
            }
            selectedStopsIndex.removeFirst()
        }
        selectedStopsIndex.append(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StopsCell else
        { return }
        
        cell.deselectCell()
        if let selectedIndex = selectedStopsIndex.firstIndex(of: indexPath.row) {
            selectedStopsIndex.remove(at: selectedIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StopsCell.identifier, for: indexPath) as? StopsCell,
              let stop = ApiManager.multiRouteStops[safe: indexPath.row]
        else { return UITableViewCell() }
        
        
        
        cell.viewModel = StopsCell.ViewModel(text: formatStops(stop))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiManager.multiRouteStops.count
    }
    
    func formatStops(_ item: (String, [String])) -> String {
        let format = "%@, %@."
        return "\(item.0) - \(String(format: "%@, %@", arguments: item.1))"
    }
}

private extension StopsVC {
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(goButton)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        goButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-140)
            make.width.height.equalTo(60)
        }
    }
    
    func showGoButtonIfNeeded() {
        if selectedStopsIndex.count >= 2 {
            goButton.isHidden = false
        } else {
            goButton.isHidden = true
        }
    }
    
    @objc func reloadTable() {
        tableView.reloadData()
    }
}
