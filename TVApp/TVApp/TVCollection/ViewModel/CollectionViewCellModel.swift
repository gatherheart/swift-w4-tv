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
    
    let image: UIImage!
    let title: String!
    let duration: String!
    let viewCount: String!
    let channelName: String!
    let createTime: String!
    
    init(tvModel: TvModel) {
        title = tvModel.displayTitle
        (image, viewCount) = TvCollectionViewCellModel.dealWithDifferentTypes(tvModel: tvModel)
        duration = TvCollectionViewCellModel.changeDurationFormat(duration: tvModel.duration)
        channelName = tvModel.channel.name
        createTime = TvCollectionViewCellModel.changeCreateTimeFormat(createTime: tvModel.createTime ?? "")
    }
    
    private static func dealWithDifferentTypes(tvModel: TvModel) -> (UIImage?, String) {
        if tvModel.videoType == .CLIP {
            let _image = UIImage(named: tvModel.clip?.thumbnailUrl ?? "default")
            let _viewCount = TvCollectionViewCellModel.changeViewCountFormat(viewCount: tvModel.clip?.playCount ?? 0)
            return (_image, _viewCount)
        }
        else if tvModel.videoType == .LIVE {
            let _image = UIImage(named: tvModel.live?.thumbnailUrl ?? "default")
            let _viewCount = TvCollectionViewCellModel.changeViewCountFormat(viewCount: tvModel.live?.playCount ?? 0)
            return (_image, _viewCount)
        }
        else {
            return (nil, "")
        }
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
            return String(Int(seconds / TimeUnit.day.rawValue))
        }
        else if seconds >= TimeUnit.hour.rawValue {
            return String(Int(seconds / TimeUnit.hour.rawValue))
        }
        else if seconds >= TimeUnit.minute.rawValue {
            return String(Int(seconds / TimeUnit.minute.rawValue))
        }
        else {
            return String(seconds)
        }
        
    }
    
    
}
