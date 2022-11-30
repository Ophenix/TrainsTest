//
//  ArrayExtension.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 29/11/2022.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        .zero..<count ~= index ? self[index] : nil
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
