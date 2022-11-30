//
//  StopsCell.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 29/11/2022.
//

import UIKit

final class StopsCell: UITableViewCell {    
    struct ViewModel {
        let text: String
    }
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.textColor = .systemTeal
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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

extension StopsCell {
    func selectCell() {
        backgroundColor = .darkGray
    }
    
    func deselectCell() {
        backgroundColor = .clear
    }
}

private extension StopsCell {
    func addSubviews() {
        contentView.addSubview(titleText)
    }
    
    func setupLayout() {
        guard let viewModel else { return }
        titleText.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.bottom.leading.equalToSuperview()
        }
        
        
        titleText.text = viewModel.text
        
    }
}
