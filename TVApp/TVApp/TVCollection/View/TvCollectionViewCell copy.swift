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
    var id: Int = 0
    
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
    }

    func config(id: Int, image: String, title: String, description: String) {
        self.id = id
        self.thumbnail.image = UIImage(named: image)
        self.title.text = title
        self.descriptionLabel.text = description
    }

    func config(viewModel: TvCollectionViewCellModel) {
        id = viewModel.id
        title?.text = viewModel.title
        thumbnail?.contentMode = .scaleAspectFit
        if viewModel.videoType == .CLIP {
            thumbnail?.image = viewModel.image
        } else if viewModel.videoType == .LIVE {
            thumbnail?.image = viewModel.image
        }
        descriptionLabel?.text = "\(viewModel.channelName) \(viewModel.viewCount) \(viewModel.createTime)"
    }

}
