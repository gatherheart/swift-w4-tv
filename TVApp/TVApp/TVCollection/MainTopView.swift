//
//  MainTopView.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import UIKit

class MainTopView: UIView {

    @IBOutlet weak var search: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        
    }

    private func setUI() {
        setSearch()
    }

    private func setSearch() {
        search.layer.cornerRadius = 8
        search.clipsToBounds = true
        search.clearButtonMode = .whileEditing
        search.leftViewMode = .always
        let padding: CGFloat = 8
        let imageSize: CGFloat = search.frame.height * 0.65
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: padding * 2 + imageSize, height: imageSize))
        let imageView = UIImageView(frame: CGRect(x: padding, y: 0, width: imageSize, height: imageSize))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .gray
        outerView.addSubview(imageView)
        search.leftView = outerView
    }

    func setConstraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

}

extension MainTopView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      return true
    }
}
