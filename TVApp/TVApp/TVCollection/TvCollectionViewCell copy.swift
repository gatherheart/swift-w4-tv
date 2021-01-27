//
//  TvCollectionViewCell.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import UIKit

class TvCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 2
    }
    
    func config(image: String, title: String, description: String) {
        self.thumbnail.image = UIImage(named: image)
        self.title.text = title
        self.descriptionLabel.text = description
    }
    
    func config(tvModel: TvModel) {
        title.text = tvModel.displayTitle
        thumbnail.contentMode = .scaleAspectFit
        if tvModel.videoType == .CLIP {
            thumbnail.image = UIImage(named: tvModel.clip?.thumbnailUrl ?? "default")
        }
        else if tvModel.videoType == .LIVE {
            thumbnail.image = UIImage(named: tvModel.live?.thumbnailUrl ?? "default")
        }
        
    }

}
