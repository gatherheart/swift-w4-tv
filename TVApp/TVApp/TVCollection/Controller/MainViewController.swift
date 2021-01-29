//
//  ViewController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/25.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var tvCollectionView: TvCollectionView!
    var mainTopView: MainTopView!
    let tvModelController = TvModelController()
    let touchHandler = TouchHandler()
    let coreDataManger = CoreDataManager()
    var dataSource: UICollectionViewDiffableDataSource<Section, TvModel>!
    var nameFilter: String?
    let topViewHeight: CGFloat = 120
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(goToFavoriteView))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        setNavigationBar()
        setMainTopView()
        setCollectionView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "KakaoTV"
        navigationItem.rightBarButtonItem = rightButton
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
    
    @objc private func goToFavoriteView(_ sender: Any) {
        self.performSegue(withIdentifier: "goToFavoriteView", sender: sender)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        touchHandler.determineGestureType(touches, with: event, completed: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchHandler.determineGestureType(touches, with: event) { [weak self] type in
            if type == .longPress {
                if let cell = touches.first?.view as? TvCollectionViewCell {
                    if let tvModel = self?.tvModelController.findById(id: cell.id) {
                        self?.coreDataManger.save(tvModel: tvModel)
                    }
                }
            }
        }
    }

}

extension MainViewController: MainTopViewDelegate {
    func didSegmentChange(segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            performQuery(with: TvModel.VideoType.CLIP)
        case 1:
            performQuery(with: TvModel.VideoType.LIVE)
        default:
            performQuery(with: TvModel.VideoType.CLIP)

        }
    }
}

extension MainViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension MainViewController {
    enum Section: CaseIterable {
        case main
    }
    func configureDataSource() {
        let cellRegistration = TvCollectionView.CellRegistration
        <TvCollectionViewCell, TvModel> { (cell, _, tvModel) in
            cell.config(viewModel: TvCollectionViewCellModel(tvModel: tvModel))
        }

        dataSource = UICollectionViewDiffableDataSource<Section, TvModel>(collectionView: tvCollectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, tvModel: TvModel) -> UICollectionViewCell? in
            guard let self = self else { return TvCollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvCollectionViewCell", for: indexPath) as? TvCollectionViewCell
            else { return TvCollectionViewCell() }
            cell.config(viewModel: TvCollectionViewCellModel(tvModel: tvModel))
            cell.backgroundColor = .red
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
