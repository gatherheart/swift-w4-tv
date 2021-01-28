//
//  ViewController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/25.
//

import UIKit

class MainViewController: UIViewController {
    var tvCollectionView: TvCollectionView!
    var mainTopView: UIView!
    var topViewHeight: CGFloat = 120
    let bundleManager: BundleManager = BundleManager()
    var originalList: TvModelListType!
    var liveList: TvModelListType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        TvUseCase.getOriginal(with: bundleManager) {
            (tvModelList) in
            self.originalList = tvModelList
            self.tvCollectionView.reloadData()
        }
    }

    private func setUI() {
        navigationItem.title = "KakaoTV"
        setMainTopView()
        setCollectionView()
    }

    private func setMainTopView() {
        let bundle = Bundle.init(for: self.classForCoder)
        guard let subView = bundle.loadNibNamed("MainTopView", owner: self, options: nil)?.first as? UIView else { return }
        self.view.addSubview(subView)
        mainTopView = subView
        setMainTopViewConstraints()
    }

    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        tvCollectionView = TvCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tvCollectionView.config(sender: self, topOffset: self.topViewHeight)
        self.view.addSubview(tvCollectionView)
        setTvCollectionViewConstraints()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }

}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originalList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvCollectionViewCell", for: indexPath) as? TvCollectionViewCell else {
            return TvCollectionViewCell()
        }
        cell.backgroundColor = .red
        cell.config(viewModel: TvCollectionViewCellModel(tvModel: originalList[indexPath.row]))
        return cell
    }
}

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
