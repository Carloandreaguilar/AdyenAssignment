//
//  PlacesNetworkRepository.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import Foundation

protocol PlacesRepositoryProtocol {
    func fetchPlaces(query: String?, radius: Int, sortType: PlacesSortType, itemsToLoad: Int, locationCoordinates: Coordinates) async throws -> [Place]
    func fetchPlacePhotos(id: String) async throws -> [PlacePhotoInfo]
}


struct PlacesNetworkRepository: PlacesRepositoryProtocol {
    let baseUrl = "https://api.foursquare.com/v3/places"
    /**** Of course, this key should not be in the code, ideally it should be encrypted and stored in the cloud somewhere for security reasons */
    let APIKey = "fsq3cdAQboKv271zFxmKZw5fy3/cvz3SQY20VeveWY6q5Mg="
    
    func fetchPlaces(query: String?, radius: Int, sortType: PlacesSortType, itemsToLoad: Int, locationCoordinates: Coordinates) async throws -> [Place] {
        let requestUrlString = baseUrl.appending(formattedSearchParametersPathExtension(query: query, radius: radius, sortType: sortType, itemsToLoad: itemsToLoad, locationCoordinates: locationCoordinates))
        guard let requestUrl = URL(string: requestUrlString) else {
            fatalError("Invalid URL")
        }
        
        let urlRequest = urlRequestWithHeaders(url: requestUrl)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard responseWasSucessful(response: response) else {
            fatalError("Error retreiving data")
        }
        
        var places: [Place] = []
        
        do {
            let decodedResponse = try JSONDecoder().decode(PlaceSearchAPIResponse.self, from: data)
            for placeDTO in decodedResponse.results {
                places.append(Place(fromDTO: placeDTO))
            }
        } catch {
            print(error)
            throw error
        }
        
        return places
    }
    
    func fetchPlacePhotos(id: String) async throws -> [PlacePhotoInfo] {
        guard let url = URL(string: baseUrl + "/\(id)/photos") else {
            fatalError("Invalid URL")
        }
        let urlRequest = urlRequestWithHeaders(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard responseWasSucessful(response: response) else {
            fatalError("Error retreiving data")
        }
        
        do {
            let photos = try JSONDecoder().decode(PlacePhotosResponse.self, from: data)
            print(photos)
            return photos
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchImageDataFromUrl(url: URL) async throws -> Data {
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return data
    }
    
    private func formattedSearchParametersPathExtension(query: String?, radius: Int, sortType: PlacesSortType, itemsToLoad: Int, locationCoordinates: Coordinates) -> String {
        var parameters: [Parameter] = []
        if let query = query, !query.isEmpty {
            parameters.append(Parameter(key: .query, value: query))
        }
        let cappedRadius = radius <= 100000 ? radius : 100000
        parameters.append(Parameter(key: .radius, value: String(cappedRadius)))
        parameters.append(Parameter(key: .sort, value: sortType.rawValue))
        parameters.append(Parameter(key: .itemsToLoad, value: String(itemsToLoad)))
        parameters.append(Parameter(key: .LatLong, value: "\(locationCoordinates.latitude)%2C\(locationCoordinates.longitude)"))
        
        var urlExtension = "/search?"
        let maxParameterIndex = parameters.count - 1
        
        for index in 0...maxParameterIndex {
            let parameter = parameters[index]
            urlExtension.append("\(parameter.key.rawValue)=\(parameter.value)")
            if index < maxParameterIndex {
                urlExtension.append("&")
            }
        }
        return urlExtension
    }
    
    private func urlRequestWithHeaders(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(APIKey, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    private func responseWasSucessful(response: URLResponse) -> Bool {
        return (response as? HTTPURLResponse)?.statusCode == 200
    }
}

private extension PlacesNetworkRepository {
    enum ParameterKey: String {
        case query, radius, sort, itemsToLoad = "limit", LatLong = "ll"
    }
    struct Parameter {
        let key: ParameterKey
        let value: String
    }
}



