//
//  MainTopView.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import UIKit

protocol MainTopViewDelegate: NSObject {
    func didSegmentChange(segmentControl: UISegmentedControl)
}

class MainTopView: UIView {

    weak var delegate: MainTopViewDelegate?

    @IBOutlet weak var segmentControl: UISegmentedControl!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        delegate?.didSegmentChange(segmentControl: segmentControl)
    }

}

extension MainTopView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      return true
    }
}
