//
//  StopModel.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import Foundation

struct StopsModelContainer: Codable {
    struct StopModel: Codable {
        struct StopAttributes: Codable {
            let name: String
        }
        
        let attributes: StopAttributes
    }
    
    let data: [StopModel]
}

/*
 {
   "links": {
     "self": "string",
     "prev": "string",
     "next": "string",
     "last": "string",
     "first": "string"
   },
   "data": [
     {
       "type": "string",
       "relationships": {
         "parent_station": {
           "links": {
             "self": "string",
             "related": "string"
           },
           "data": {
             "type": "string",
             "id": "string"
           }
         }
       },
       "links": {},
       "id": "string",
       "attributes": {
         "wheelchair_boarding": 0,
         "vehicle_type": 3,
         "platform_name": "Red Line",
         "platform_code": "5",
         "on_street": "Massachusetts Avenue",
         "name": "Parker St @ Hagen Rd",
         "municipality": "Cambridge",
         "longitude": 42.316115,
         "location_type": 0,
         "latitude": -71.194994,
         "description": "Alewife - Red Line",
         "at_street": "Essex Street",
         "address": "Alewife Brook Parkway and Cambridge Park Drive, Cambridge, MA 02140"
       }
     }
   ]
 }
 */
