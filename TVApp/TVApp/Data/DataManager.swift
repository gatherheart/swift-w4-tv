//
//  DataManager.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/27.
//

import Foundation

protocol BundleManable {
    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws
}

enum BundleDataErrorCase: Error {
    case invalidPath
    case notFound
}

class BundleManager: BundleManable {

    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws {
        guard let url = Bundle.main.url(forResource: from, withExtension: "json") else { throw BundleDataErrorCase.notFound }
        do {
            let data = try Data(contentsOf: url)
            print(data)
            completion(data, nil)
        } catch let error {
            completion(nil, error)
        }
    }
}
