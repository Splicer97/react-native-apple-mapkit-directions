import MapKit

@objc(AppleMapkitDirections)
class AppleMapkitDirections: NSObject {

@objc(getAppleMapKitDirections:toDestination:byTransitType:withResolver:withRejecter:)
    func getAppleMapKitDirections(origin: Dictionary<String, Double>,
                        destination: Dictionary<String, Double>,
                        transitType: NSString,
                        resolve:@escaping RCTPromiseResolveBlock,
                        reject:@escaping RCTPromiseRejectBlock) -> Void {

        let request = MKDirections.Request();

        request.source = MKMapItem(placemark:
                                    MKPlacemark(coordinate:
                                                    CLLocationCoordinate2D(
                                                        latitude: origin["latitude"] ?? 0.00,
                                                        longitude: origin["longitude"] ?? 0.00),
                                                addressDictionary: nil))


        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(
            latitude: destination["latitude"] ?? 0.00,
            longitude: destination["longitude"] ?? 0.00),
                                                               addressDictionary: nil))
        request.transportType = .any

        switch transitType {
        case "automobile":
            request.transportType = .automobile;
            break;
        case "walking":
            request.transportType = .walking;
        case "transit":
            request.transportType = .transit;
        case "any":
            request.transportType = .any;
        default:
            request.transportType = .any;
        }

        let directions = MKDirections(request: request)

        directions.calculate(completionHandler: {(response, error) in
            guard let response = response else {
                if let error = error {
                    reject("500", error.localizedDescription, error)
                }
                return
            }



            if response.routes.count > 0 {

                let route = response.routes[0]

                let points = route.polyline.points()

                let result: NSMutableArray = []

                for i in 1...route.polyline.pointCount - 1 {

//                    pointsArray.append([points[i].coordinate.latitude, points[i].coordinate.longitude])

                    let point: NSMutableDictionary = [:]
                    point["latitude"] = points[i].coordinate.latitude
                    point["longitude"] = points[i].coordinate.longitude
                    result.add(point)
                }

                var resp: Dictionary = [:] as [String : Any];
                resp["distance"] = route.distance as Double;
                resp["expectedTravelTime"] = route.expectedTravelTime as Double;
                resp["name"] = route.name;
                resp["advisoryNotices"] = route.advisoryNotices;
                resp["coordinates"] = result


                resolve(resp)
            }
        })
    }
}
