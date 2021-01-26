//
//  ViewController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/25.
//

import UIKit

class MainViewController: UIViewController {
    var mainTopView: MainTopView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "KakaoTV"
        setUI()
    }
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        setMainTopViewConstraints()
    }

    private func setUI() {
        setMainTopView()
    }

    private func setMainTopView() {
        let screenWidth = UIScreen.main.bounds.size.width
        mainTopView = MainTopView(frame: CGRect(x: 0, y: self.topbarHeight, width: screenWidth, height: 240))

        self.view.addSubview(mainTopView)
        setMainTopViewConstraints()
    }

    func setMainTopViewConstraints() {
        let margins = self.view.safeAreaLayoutGuide
        mainTopView.layer.borderWidth = 1
        mainTopView.translatesAutoresizingMaskIntoConstraints = false
        mainTopView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mainTopView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
        mainTopView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        mainTopView.heightAnchor.constraint(greaterThanOrEqualToConstant: 240).isActive = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }

}
