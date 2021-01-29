//
//  FavoriteTableViewController.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/29.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    let coreDataManger = CoreDataManager()
    let cellReuseIdentifier = "FavoriteViewCell"
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return coreDataManger.favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? UITableViewCell {
            if let favorite = coreDataManger.favorites[indexPath.row] as? Favorite {
                let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 40))
                title.textColor = UIColor.black
                title.text = favorite.displayTitle
                title.textAlignment = .center
                cell.contentView.addSubview(title)
                return cell
            }
        }
        return UITableViewCell()
    }
    
}

