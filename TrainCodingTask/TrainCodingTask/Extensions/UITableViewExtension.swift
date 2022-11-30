//
//  UITableViewExtension.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 29/11/2022.
//

import UIKit

extension UITableView {
    func reloadVisibleCells() {
        guard let visible = self.indexPathsForVisibleRows else { return }
        self.beginUpdates()
        reloadRows(at: visible, with: .none)
        self.endUpdates()
    }
}
