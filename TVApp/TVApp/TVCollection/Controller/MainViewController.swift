//
//  ViewController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/25.
//

import UIKit

class MainViewController: UIViewController {
    enum Section: CaseIterable {
        case main
    }
    
    var tvCollectionView: TvCollectionView!
    var mainTopView: MainTopView!
    let tvModelController = TvModelController()
    var dataSource: UICollectionViewDiffableDataSource<Section, TvModel>!
    var nameFilter: String?
    let topViewHeight: CGFloat = 120
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
        
    private func setUI() {
        navigationItem.title = "KakaoTV"
        setMainTopView()
        setCollectionView()
    }

    private func setMainTopView() {
        let bundle = Bundle.init(for: self.classForCoder)
        guard let subView = bundle.loadNibNamed("MainTopView", owner: self, options: nil)?.first as? MainTopView else { return }
        self.view.addSubview(subView)
        mainTopView = subView
        mainTopView.delegate = self
        setMainTopViewConstraints()
    }

    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        tvCollectionView = TvCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tvCollectionView.config(sender: self, topOffset: self.topViewHeight)
        self.view.addSubview(tvCollectionView)
        setTvCollectionViewConstraints()
        configureDataSource()
        performQuery(with: TvModel.VideoType.CLIP)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension MainViewController: MainTopViewDelegate {
    func didSegmentChange(segmentControll: UISegmentedControl) {
    }
}


extension MainViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension MainViewController {

    func configureDataSource() {
        
        let cellRegistration = TvCollectionView.CellRegistration
        <TvCollectionViewCell, TvModel> { (cell, indexPath, tvModel) in
            // Populate the cell with our item description.
            
            cell.config(viewModel: TvCollectionViewCellModel(tvModel: tvModel))
            print(tvModel.displayTitle)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, TvModel>(collectionView: tvCollectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: TvModel) -> UICollectionViewCell? in
            // Return the cell.
            guard let self = self else { return TvCollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvCollectionViewCell", for: indexPath) as? TvCollectionViewCell
            else { return TvCollectionViewCell() }
            cell.config(viewModel: TvCollectionViewCellModel(tvModel: self.tvModelController.get(index: indexPath.row)))
            return cell
        }
    }
    
    private func performQuery(with filter: TvModel.VideoType?) {
        let tvList = self.tvModelController.filteredTvList(with: filter)
        var snapshot = NSDiffableDataSourceSnapshot<Section, TvModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tvList, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func performQuery(with filter: String?) {
        let tvList = self.tvModelController.filteredTvList(with: filter)
        var snapshot = NSDiffableDataSourceSnapshot<Section, TvModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tvList, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
