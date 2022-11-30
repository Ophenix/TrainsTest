//
//  ApiManager.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import Foundation
import Alamofire

fileprivate struct ApiConsts {
    static let baseUrl = "https://api-v3.mbta.com/"
    static let getRoutesUrl = baseUrl + "routes?filter%5Btype%5D=0%2C1"
    private static let getStops = baseUrl + "stops?filter%5Broute%5D="
    
    static func getStopsFor(route: String) -> String {
        return getStops + route
    }
}

final class ApiManager {
    /// Using this as a datastore originally I wanted the VC to use it's data as a viewModel but we need to share data between VCs and this makes more sense.
    private(set) static var routes: [RoutesModelContainer.RouteModel] = []
    private(set) static var longestCount: Int = 0
    private(set) static var shortestCount: Int = 0
    private(set) static var multiRouteStops: [(String, [String])] = []
    
    static let headers: HTTPHeaders = [
        "X-API-Key": "55757a6797034b0fa545402354809b33",
        "Accept": "application/json"
    ]
}

extension ApiManager {
    static func getRoutesData(completion: @escaping ()->()) {
        getRoutes(completion: { result in
            switch result {
            case .success(let models):
                routes = models
                
                models.enumerated().forEach({
                    let routeId = $0.1.id
                    let routeIndex = $0.0
                    getStops(for: routeId, completion: { result in
                        switch result {
                        case .success(let stops):
                            self.routes[routeIndex].stops = stops
                            if routeIndex == self.routes.count - 1 {
                                calculateStops()
                                calculateRoutes()
                                completion()
                            }
                        case .failure(let _):
                            // TODO error handling
                            break
                        }
                    })
                })
                
            case .failure(let _):
                // TODO error handling
                break
            }
        })
    }
}

private extension ApiManager {
    private static func calculateRoutes() {
        let stopCount = routes.compactMap({ $0.stops?.count })
        
        longestCount = stopCount.max() ?? 0
        shortestCount = stopCount.min() ?? 0
    }
    
    private static func calculateStops() {
        var mutibleStops: [String: [String]] = [:]
        routes.forEach({ route in
            if let stops = route.stops {
                stops.forEach({ stop in
                    if mutibleStops.keys.contains(stop.attributes.name) {
                        mutibleStops[stop.attributes.name]!.append(route.attributes.longName)
                    } else {
                        mutibleStops[stop.attributes.name] = [route.attributes.longName]
                    }
                })
            }
        })
        multiRouteStops = mutibleStops.filter({ stop in
            stop.value.count >= 2
        }).map({ ($0.key, $0.value)})
    }
    
    private static func getRoutes(completion: @escaping (Result<[RoutesModelContainer.RouteModel], Error>)->()) {
        let request = AF.request(ApiConsts.getRoutesUrl, headers: headers)
        
        request.responseDecodable(of: RoutesModelContainer.self) { response in
            guard let routes = response.value else { return } // TODO: Error handling
                    
            completion(Result.success(routes.data))
        }
    }
    
    private static func getStops(for route: String, completion: @escaping (Result<[StopsModelContainer.StopModel], Error>)->()) {
        let request = AF.request(ApiConsts.getStopsFor(route: route), headers: headers)
        
        request.responseDecodable(of: StopsModelContainer.self) { response in
            guard let stops = response.value else { return } // TODO: Error handling
                    
            completion(Result.success(stops.data))
        }
    }
}
