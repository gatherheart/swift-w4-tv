//
//  MainTopView.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import UIKit

protocol MainTopViewDelegate: NSObject {
    func didSegmentChange(segmentControl: UISegmentedControl)
    func didSearchChange(search: UISearchBar)
}

class MainTopView: UIView {

    weak var delegate: MainTopViewDelegate?
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        search.delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        search.delegate = self
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        delegate?.didSegmentChange(segmentControl: segmentControl)
    }
    
}

extension MainTopView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didSearchChange(search: search)
    }
}
