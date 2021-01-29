//
//  CollectionViewCellModel.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/27.
//

import UIKit

struct TvCollectionViewCellModel {

    enum TimeUnit: Int {
        case second=1, minute=60, hour=3600, day=86400
    }
    
    let id: Int
    let image: UIImage!
    let title: String
    let duration: String
    let viewCount: String
    let channelName: String
    let createTime: String
    let videoType: TvModel.VideoType

    init(tvModel: TvModel) {
        id = tvModel.id
        title = tvModel.displayTitle
        channelName = tvModel.channel.name
        videoType = tvModel.videoType
        image = TvCollectionViewCellModel.getImageFromTvModel(tvModel: tvModel)
        duration = TvCollectionViewCellModel.getDurationFromTvModel(tvModel: tvModel)
        viewCount = TvCollectionViewCellModel.getViewCountFromTvModel(tvModel: tvModel)
        createTime = TvCollectionViewCellModel.getCreateTimeFromTvModel(tvModel: tvModel)
    }

    private static func getImageFromTvModel(tvModel: TvModel) -> UIImage? {
        if tvModel.videoType == .CLIP {
            return UIImage(named: tvModel.clip?.thumbnailUrl ?? "default")
        } else if tvModel.videoType == .LIVE {
            return UIImage(named: tvModel.live?.thumbnailUrl ?? "default")
        }
        return nil
    }

    private static func getViewCountFromTvModel(tvModel: TvModel) -> String {
        if tvModel.videoType == .CLIP {
            return TvCollectionViewCellModel.changeViewCountFormat(viewCount: tvModel.clip?.playCount ?? 0)
        } else if tvModel.videoType == .LIVE {
            return TvCollectionViewCellModel.changeViewCountFormat(viewCount: tvModel.live?.playCount ?? 0)
        }
        return ""
    }

    private static func getDurationFromTvModel(tvModel: TvModel) -> String {
        if tvModel.videoType == .CLIP {
            return TvCollectionViewCellModel.changeDurationFormat(duration: tvModel.clip?.duration ?? 0)
        } else if tvModel.videoType == .LIVE {
            return TvCollectionViewCellModel.changeDurationFormat(duration: tvModel.live?.duration ?? 0)
        }
        return ""
    }

    private static func getCreateTimeFromTvModel(tvModel: TvModel) -> String {
        if tvModel.videoType == .CLIP {
            return TvCollectionViewCellModel.changeCreateTimeFormat(createTime: tvModel.clip?.createTime ?? "")
        } else if tvModel.videoType == .LIVE {
            return TvCollectionViewCellModel.changeCreateTimeFormat(createTime: tvModel.live?.createTime ?? "")
        }
        return ""
    }

    private static func changeDurationFormat(duration: Int) -> String {
        let hours: Int = duration / TimeUnit.hour.rawValue
        let minutes: Int = (duration - hours * TimeUnit.hour.rawValue) / TimeUnit.minute.rawValue
        let seconds: Int = duration - (duration - hours * TimeUnit.hour.rawValue) - (duration - minutes * TimeUnit.minute.rawValue)
        return hours != 0 ? "\(hours):\(minutes):\(seconds)" : "\(minutes):\(seconds)"
    }

    private static func changeViewCountFormat(viewCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: viewCount as NSNumber) ?? ""
    }

    private static func changeCreateTimeFormat(createTime: String) -> String {
        func secondsBetween(start: Date, end: Date) -> Int? {
            return Calendar.current.dateComponents([.second], from: start, to: end).second
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let startDate: Date = dateFormatter.date(from: createTime) ?? Date()
        let seconds = secondsBetween(start: startDate, end: Date()) ?? 0

        if seconds >= TimeUnit.day.rawValue {
            return "\(Int(seconds / TimeUnit.day.rawValue))일 전"
        } else if seconds >= TimeUnit.hour.rawValue {
            return "\(Int(seconds / TimeUnit.hour.rawValue))시간 전"
        } else if seconds >= TimeUnit.minute.rawValue {
            return "\(Int(seconds / TimeUnit.minute.rawValue))분 전"
        } else {
            return "\(seconds)초 전"
        }

    }

}
