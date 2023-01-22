//
//  NetworkManager.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation
import Alamofire
import Network

protocol NetworkManagerInterface {
    func login(username: String, password: String, completion: @escaping (ResultTypeEnum<LoginResponseModel>) -> Void)
    func fetchProducts(completion: @escaping (ResultTypeEnum<Product>) -> Void)
}

protocol InternetProtocol {
    func checkInternet(completion: @escaping (Bool) -> ())
}

struct NetworkManager: NetworkManagerInterface {
    static let shared = NetworkManager()
    
    func login(username: String, password: String, completion: @escaping (ResultTypeEnum<LoginResponseModel>) -> Void) {
        let params: Parameters = [
            "username": username,
            "password": password
        ]
        if !username.isEmpty && !password.isEmpty {
            let urlString = ApiUrlEnum.login()
            AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(.loginError))
                    }
                case .failure(_):
                    completion(.failure(.internetError))
                }
            }
        } else {
            completion(.failure(.userLoginInfoError))
        }

    }
    
    func fetchProducts(completion: @escaping (ResultTypeEnum<Product>) -> Void) {
        let urlString = ApiUrlEnum.fetchProducts()
        checkInternet { internetStatus in
            if internetStatus {
                AF.request(urlString).responseDecodable(of: Product.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        CacheManager.shared.setProducst(products: data)
                    case .failure(_):
                        completion(.failure(.fetchError))
                    }
                }
            } else {
                CacheManager.shared.getProducts { products in
                    if let products = products {
                        completion(.success(products))
                        return
                    }
                    completion(.failure(.internetError))
                }
            }
        }
        

    }
}


extension NetworkManager: InternetProtocol {
    func checkInternet(completion: @escaping (Bool) -> ()) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
        }
        monitor.start(queue: queue)
    }
}
