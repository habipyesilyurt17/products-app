//
//  NetworkManager.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func login(username: String, password: String, completion: @escaping (ResultTypeEnum<LoginResponseModel>) -> Void)
    func fetchProducts(completion: @escaping (ResultTypeEnum<Product>) -> Void)
}

struct NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    func login(username: String, password: String, completion: @escaping (ResultTypeEnum<LoginResponseModel>) -> Void) {
        let params: Parameters = [
            "username": username,
            "password": password
        ]
        let urlString = ApiUrlEnum.login()
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }
    
    func fetchProducts(completion: @escaping (ResultTypeEnum<Product>) -> Void) {
        let urlString = ApiUrlEnum.fetchProducts()
        AF.request(urlString).responseDecodable(of: Product.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.fetchError))
            }
        }
    }
}
