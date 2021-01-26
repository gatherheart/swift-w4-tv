//
//  TvCollectionViewCell.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import UIKit

class TvCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 2
        self.backgroundColor = .darkGray
    }

}
