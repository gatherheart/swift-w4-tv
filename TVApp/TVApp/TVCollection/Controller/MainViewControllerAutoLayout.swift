//
//  MainViewControllerAutoLayout.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/28.
//

import UIKit

extension MainViewController {
    func setMainTopViewConstraints() {
        let margins = self.view.safeAreaLayoutGuide
        mainTopView.translatesAutoresizingMaskIntoConstraints = false
        mainTopView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mainTopView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
        mainTopView.heightAnchor.constraint(equalToConstant: topViewHeight).isActive = true
    }

    func setTvCollectionViewConstraints() {
        let margins = self.view.safeAreaLayoutGuide
        tvCollectionView.backgroundColor = .green
        tvCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tvCollectionView.topAnchor.constraint(equalTo: mainTopView.bottomAnchor).isActive = true
        tvCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        ).isActive = true
        tvCollectionView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
        tvCollectionView.centerXAnchor.constraint(equalTo: mainTopView.centerXAnchor).isActive = true
        tvCollectionView.heightAnchor.constraint(greaterThanOrEqualTo: margins.heightAnchor, multiplier: 1, constant: -topViewHeight).isActive = true
    }
}
