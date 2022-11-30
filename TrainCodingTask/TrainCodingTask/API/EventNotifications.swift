//
//  EventNotifications.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 29/11/2022.
//

import Foundation

enum EventNotifications: String {
    case dataLoaded
    
    var name: Notification.Name {
        return Notification.Name(self.rawValue)
    }
}
