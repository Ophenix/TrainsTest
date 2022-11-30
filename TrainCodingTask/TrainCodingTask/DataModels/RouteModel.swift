//
//  RouteModel.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import Foundation
struct RoutesModelContainer: Codable {
    struct RouteModel: Codable {
        struct RouteAttributes: Codable {
            let color: String
            let description: String
            let longName: String
            
            enum CodingKeys: String, CodingKey {
                case color, description, longName = "long_name"
            }
        }
        let attributes: RouteAttributes
        let id: String
        var stops: [StopsModelContainer.StopModel]?
    }
    
    let data: [RouteModel]
}

/*
 {
   "data": [
     {
       "attributes": {
         "color": "00843D",
         "description": "Rapid Transit",
         "direction_destinations": [
           "Heath Street",
           "Lechmere"
         ],
         "direction_names": [
           "West",
           "East"
         ],
         "fare_class": "Rapid Transit",
         "long_name": "Green Line E",
         "short_name": "E",
         "sort_order": 10035,
         "text_color": "FFFFFF",
         "type": 0
       },
       "id": "Green-E",
       "links": {
         "self": "/routes/Green-E"
       },
       "relationships": {
         "line": {
           "data": {
             "id": "line-Green",
             "type": "line"
           }
         },
         "stop": {
           "data": {
             "id": "70260",
             "type": "stop"
           }
         }
       },
       "type": "route"
     }
   ],
   "included": [
     {
       "attributes": {
         "address": null,
         "at_street": null,
         "description": "Heath Street - Green Line",
         "latitude": 42.328316,
         "location_type": 0,
         "longitude": -71.110252,
         "municipality": "Boston",
         "name": "Heath Street",
         "on_street": null,
         "platform_code": null,
         "platform_name": "Green Line",
         "vehicle_type": 0,
         "wheelchair_boarding": 1
       },
       "id": "70260",
       "links": {
         "self": "/stops/70260"
       },
       "relationships": {
         "facilities": {
           "links": {
             "related": "/facilities/?filter[stop]=70260"
           }
         },
         "parent_station": {
           "data": {
             "id": "place-hsmnl",
             "type": "stop"
           }
         },
         "zone": {
           "data": {
             "id": "RapidTransit",
             "type": "zone"
           }
         }
       },
       "type": "stop"
     }
   ],
   "jsonapi": {
     "version": "1.0"
   }
 }
*/
