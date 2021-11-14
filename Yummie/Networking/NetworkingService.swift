//
//  NetworkingService.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 9/10/21.
//

import UIKit
struct NetworkingService {
    
    
    static let shared = NetworkingService()
    
    private init(){} //so you can't initialize it outside of this struct
    
    
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    
    
    func placeOder(dishId: String, name: String, completion: @escaping(Result<Order, Error>) -> Void) {
        let params = ["name": name]
        request(route: .placeOrder(dishId), method: .post, parameters: params, completion: completion)
    }
    
    
    
    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
        request(route: .fetchCategoryDishes(categoryId), method: .get, completion: completion)
    }
    
    
    func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
        request(route: .fetchOrders, method: .get, completion: completion)
    }
    
    private func request<T: Codable>(route: Route, method: Method, parameters: [String:Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
            
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            var result: Result<Data, Error>?
            
            if let data = data {
                result = .success(data)
//                let responseString = String(data: data, encoding: .utf8) ?? "Could not strigify our data"
//                print("The response is: \(responseString)")
                
            } else if let error = error {
                result = .failure(error)
                print("The Error is : \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                /// TODO decode our result and send back to the user
                self.handleResponse(result: result, completion: completion)
            }
            
        }.resume()
        
    }
    
    
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        
        switch result {
        case .success(let data):
            
            let decoder = JSONDecoder()
            
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
                
            } else {
                completion(.failure(AppError.unknownError))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
        
    }
    
    
    /// This func helps generate urlrequest
    /// - Parameters:
    ///   - route: the path to url resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra info you need to pass to backend
    /// - Returns: URLRequest
    private func createRequest(route: Route, method: Method, parameters: [String:Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else {return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        
        return urlRequest
    }
}
