//
//  UserViewController.swift
//  StackOverflowApp
//
//  Created by admin on 06/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundBlur: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var goldBadge: UILabel!
    @IBOutlet weak var silverBadge: UILabel!
    @IBOutlet weak var bronzeBadge: UILabel!
    @IBOutlet weak var reputations: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortBySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.isHidden = false
        userView.isHidden = true
        backgroundBlur.applyBackgroundBlur()
        view.backgroundColor = Colors.BackgroundColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
