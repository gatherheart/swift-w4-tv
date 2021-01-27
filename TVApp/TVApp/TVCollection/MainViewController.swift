//
//  ViewController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/25.
//

import UIKit

class MainViewController: UIViewController {
    var mainTopView: MainTopView!
    var tvCollectionView: UICollectionView!
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
            print(self.originalList)
            self.tvCollectionView.reloadData()
        }
    }

    private func setUI() {
        navigationItem.title = "KakaoTV"
        setMainTopView()
        setCollectionView()
    }

    private func setMainTopView() {
        mainTopView = MainTopView(frame: CGRect.zero)
        self.view.addSubview(mainTopView)
        setMainTopViewConstraints()
    }

    private func setCollectionView() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let collectionViewHeight = screenHeight-topViewHeight-self.topbarHeight
        print(screenHeight-topViewHeight-self.topbarHeight)
        let itemSize = UIDevice.current.userInterfaceIdiom == .phone ? collectionViewHeight/2 : screenWidth / 3 - 20
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: (screenHeight-topViewHeight-self.topbarHeight)/2.5)
        layout.minimumInteritemSpacing = 10
        tvCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tvCollectionView.layer.backgroundColor = UIColor.green.cgColor
        tvCollectionView.showsVerticalScrollIndicator = false
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
        tvCollectionView.register(TvCollectionViewCell.self, forCellWithReuseIdentifier: "TvCollectionViewCell")
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
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        tvCollectionView.backgroundColor = .green
        tvCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tvCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tvCollectionView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
        tvCollectionView.centerXAnchor.constraint(equalTo: mainTopView.centerXAnchor).isActive = true
        tvCollectionView.heightAnchor.constraint(greaterThanOrEqualTo: margins.heightAnchor, multiplier: 1, constant: -navigationBarHeight-topViewHeight).isActive = true
    }
}
