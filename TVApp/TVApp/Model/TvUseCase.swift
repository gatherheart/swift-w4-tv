//
//  TvUseCase.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import Foundation

struct TvUseCase {
    static func getOriginal(with manager: NetworkManable, completed: @escaping ([TvModel]?) -> Void) {
        try? manager.getResource(from: "/original.json") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([TvModel].self, from: tvData)
                completed(tvModels)
            }
        }
    }
    static func getLive(with manager: NetworkManable, completed: @escaping ([TvModel]?) -> Void) {
        try? manager.getResource(from: "/live.json") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([TvModel].self, from: tvData)
                completed(tvModels)
            }
        }
    }
    static func getOriginal(with manager: BundleManable, completed: @escaping ([TvModel]?) -> Void) {
        try? manager.getResource(from: "original") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([TvModel].self, from: tvData)
                completed(tvModels)
            }
        }
    }
    static func getLive(with manager: BundleManable, completed: @escaping ([TvModel]?) -> Void) {
        try? manager.getResource(from: "live") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([TvModel].self, from: tvData)
                completed(tvModels)
            }
        }
    }
}
