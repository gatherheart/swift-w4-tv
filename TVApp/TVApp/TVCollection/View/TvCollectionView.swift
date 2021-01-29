//
//  File.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/27.
//

import UIKit
extension UICollectionView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("TOUCH UIVIEW", touches.first?.view)
    }
}
class TvCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesEnded(touches, with: event)
    }

    func config(sender: Any, topOffset: CGFloat) {
        self.layer.backgroundColor = UIColor.green.cgColor
        self.showsVerticalScrollIndicator = false
        self.delegate = sender as? UICollectionViewDelegate
        self.dataSource = sender as? UICollectionViewDataSource
        let tvCollectionViewCell = UINib(nibName: "TvCollectionViewCell", bundle: nil)
        self.register(tvCollectionViewCell, forCellWithReuseIdentifier: "TvCollectionViewCell")
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let maxCollectionViewHeight = screenHeight - ((sender as? UIViewController)?.topbarHeight ?? 0)
        let itemSize = UIDevice.current.userInterfaceIdiom == .phone ? maxCollectionViewHeight/2 - 20 : screenWidth / 3 - 20
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: (maxCollectionViewHeight-topOffset)/2.3)
        self.collectionViewLayout = layout
    }

}
