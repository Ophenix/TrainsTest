//
//  RoutesCell.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import UIKit
import SnapKit

final class RoutesCell: UITableViewCell {
    struct ViewModel {
        let text: String
        let color: String
        let count: Int
        let isLongest: Bool
        let isShortest: Bool
    }
    
    // MARK: - Properties
    private lazy var titleText: UILabel = {
        return UILabel()
    }()
    
    private lazy var countText: UILabel = {
        let label = UILabel()
        label.textColor = .systemTeal
        return label
    }()
    
    private lazy var longestText: UILabel = {
        let label = UILabel()
        label.text = "Longest"
        label.textColor = .white
        label.backgroundColor = .systemPink
        label.isHidden = false
        return label
    }()
    
    private lazy var shortestText: UILabel = {
        let label = UILabel()
        label.text = "Shortest"
        label.textColor = .white
        label.backgroundColor = .systemPurple
        label.isHidden = true
        return label
    }()
    
    var viewModel: ViewModel? {
        didSet {
            setupLayout()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RoutesCell {
    func addSubviews() {
        contentView.addSubview(titleText)
        contentView.addSubview(countText)
        contentView.addSubview(longestText)
        contentView.addSubview(shortestText)
    }
    
    func setupLayout() {
        guard let viewModel else { return }
        titleText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-120)
            make.top.bottom.leading.equalToSuperview()
        }
        
        countText.snp.makeConstraints { make in
            make.leading.equalTo(titleText.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        longestText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(-4)
            make.height.equalTo(20)
        }
        
        shortestText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-14)
            make.height.equalTo(20)
        }
        titleText.text = viewModel.text
        titleText.textColor = UIColor.hexStringToUIColor(hex: viewModel.color)
        
        countText.text = "\(viewModel.count)"
        
        longestText.isHidden = !viewModel.isLongest
        shortestText.isHidden = !viewModel.isShortest
    }
}
