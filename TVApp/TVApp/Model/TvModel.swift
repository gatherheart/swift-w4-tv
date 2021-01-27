//
//  TvModel.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import Foundation

protocol TvModelListType {
    var list: [TvModel] { get }
    var count: Int { get }
    subscript(index: Int) -> TvModel { get set }
}

class TvModelList: TvModelListType {
    var list: [TvModel]
    var count: Int {
        return list.count
    }
    init(list: [TvModel]) {
        self.list = list
    }
    init() {
        self.list = [TvModel]()
    }
    subscript(index: Int) -> TvModel {
        get {
            return self.list[index]
        }
        set {
            self.list[index] = newValue
        }
    }
}

struct TvModel: Codable {
    
    enum VideoType: String, Codable {
        case CLIP, LIVE
    }
    
    let id: Int
    let channelId: Int
    let clipId: Int?
    let liveId: Int?
    let displayTitle: String?
    let createTime: String?
    let channel: Channel
    let clip: Clip?
    let live: Live?
    let videoType: VideoType
    let duration: Int
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
    let playCount: Int
    let duration: Int
    let thumbnailUrl: String
    let createTime: String
}
