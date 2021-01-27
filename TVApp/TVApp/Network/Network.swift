//
//  Network.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import Foundation

protocol NetworkManable {
    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws
}

enum NetworkErrorCase: Error {
    case invalidURL
    case notFound
}

class NetworkManager: NetworkManable {

    enum EndPoints {
        static let baseUrl =  "https://public.codesquad.kr/jk/kakao-2021"
    }

    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws {
        guard let url = URL(string: EndPoints.baseUrl+from) else { throw NetworkErrorCase.invalidURL }
        URLSession.shared.dataTask(with: url) {
            (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
}

