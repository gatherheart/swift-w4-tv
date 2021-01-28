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

    @IBOutlet weak var segmentController: UISegmentedControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        segmentController?.removeTarget(self, action: #selector(segmentChanged), for: UIControl.Event.valueChanged)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        segmentController?.addTarget(self, action: #selector(segmentChanged), for: UIControl.Event.valueChanged)
    }

    @objc func segmentChanged(segmentControl: UISegmentedControl) {
        delegate?.didSegmentChange(segmentControl: segmentControl)
    }

}

extension MainTopView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      return true
    }
}
