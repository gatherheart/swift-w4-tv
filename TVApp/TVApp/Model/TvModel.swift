//
//  TvModel.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import Foundation

protocol TvModelListType {
    var list: [TvModel] { get }
}

class TvModelList: TvModelListType {
    let list: [TvModel]
    init(list: [TvModel]) {
        self.list = list
    }
    init() {
        self.list = [TvModel]()
    }
}

struct TvModel: Codable {
    let id: Int
    let channelId: Int
    let clipId: Int?
    let liveId: Int?
    let createTime: String?
    let channel: Channel
    let clip: Clip?
    let live: Live?
}

struct Live: Codable {
    let playCount: Int
    let duration: Int
    let thumbnailUrl: String
    let createTime: String
}

struct Channel: Codable {
    let name: String
    let description: String
    let visitCount: Int
}

struct Clip: Codable {
    let duration: Int
    let thumbnailUrl: String
    let createTime: String
}
