//
//  TvModelController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/28.
//

import Foundation

class TvModelController {
    private var tvList: [TvModel] = [TvModel]()
    private let bundleManager: BundleManager = BundleManager()

    init() {
        getTvList()
    }

    private func getTvList() {
        TvUseCase.getOriginal(with: bundleManager) {
            (tvModelList) in
            self.tvList += tvModelList ?? []
        }
        TvUseCase.getLive(with: bundleManager) {
            (tvModelList) in
            self.tvList += tvModelList ?? []
        }
    }

    func findById(id: Int) -> TvModel? {
        let filtered = tvList.filter { $0.id == id }
        guard filtered.count > 0 else { return nil }
        return filtered[0]
    }
    
    func get(index: Int) -> TvModel {
        return tvList[index]
    }

    func filteredTvList(with filter: String?=nil, limit: Int?=nil) -> [TvModel] {
        let filtered = tvList.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }

    func filteredTvList(with filter: TvModel.VideoType?=nil, limit: Int?=nil) -> [TvModel] {
        let filtered = tvList.filter { $0.videoType == (filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }

}
