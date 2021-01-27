//
//  File.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/27.
//

import UIKit

class TvCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func config(sender: Any) {
        self.layer.backgroundColor = UIColor.green.cgColor
        self.showsVerticalScrollIndicator = false
        self.delegate = sender as? UICollectionViewDelegate
        self.dataSource = sender as? UICollectionViewDataSource
        let tvCollectionViewCell = UINib(nibName: "TvCollectionViewCell", bundle: nil)
        self.register(tvCollectionViewCell, forCellWithReuseIdentifier: "TvCollectionViewCell")
    }
    
}
