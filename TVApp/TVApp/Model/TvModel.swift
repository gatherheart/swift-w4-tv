//
//  TvModel.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import Foundation

struct TvModel: Codable, Hashable {

    enum VideoType: String, Codable {
        case CLIP, LIVE
    }

    let id: Int
    let channelId: Int
    let clipId: Int?
    let liveId: Int?
    let displayTitle: String
    let createTime: String?
    let channel: Channel
    let clip: Clip?
    let live: Live?
    let videoType: VideoType
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: TvModel, rhs: TvModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        return displayTitle.contains(filterText)
    }
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
