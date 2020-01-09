//
//  HomeViewController.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import UIKit

protocol ViewAnswerDelegate {
    func showAnswerForQuestion(at indexPath: Int, data: AnyObject)
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let QuestionCellIdentifier = "QuestionsTableCell"
    private var dataArray: [AnyObject] = []
    private var sortByValues: [(String, String)] = [("Latest","creation"), ("Activity","activity"), ("Hot","hot"), ("Votes","votes")]
    private var selectedSort: (String, String) = ("","")
    private var page = 1
    private var scrollToTop = false
    private let refreshControl = UIRefreshControl()
    
    var answerDelegate: ViewAnswerDelegate!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        guard Reachability.sharedInstance.isReachable() else { return }
        selectedSort = sortByValues[0]
        fetchQuestions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.BackgroundColor
        selectedSort = sortByValues.first!
        addRefreshControl()
        addRightBarButton(title: "SortBy".localized, icon: .DropDownIcon, target: self, selector: #selector(showSortByValues))
        tableView.registerTableCell(for: QuestionCellIdentifier)
        tableView.setDefaultsForTableView(
            hasFooterView: false,
            cellHeight: Constants.Sizing.QuestionCellHeight,
            headerHeight: nil,
            cellSeparatorColor: Colors.TableCellSeparator
        )
    }
    
    @objc func showSortByValues() {
        var alertActions = sortByValues.map { UIAlertAction(title: $0.0.localized, style: .default, handler: { (action) in
            self.sortQuestionsBySelectedValue(value: action.title!)
        }) }
        alertActions.append(UIAlertAction(title: "Cancel".localized, style: .destructive, handler: { (action) in
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }))
        addAlertViewController(title: "SortBy".localized, message: "SortQuestionsBy".localized, selected: selectedSort.0, alertActions: alertActions, style: .actionSheet)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count > 0 ? dataArray.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataArray.count > 0
        ? tableView.constructQuestionCell(identifier: QuestionCellIdentifier, indexPath: indexPath, data:  dataArray[indexPath.row])
        : getNoDataCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataArray.count > 0 else { return }
        answerDelegate.showAnswerForQuestion(at: indexPath.row, data: "e" as AnyObject)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard dataArray.count > 0 else { return }
        guard indexPath.row == dataArray.count - 1 else { return }
        page = page + 1
        fetchQuestions()
    }
    
    func sortQuestionsBySelectedValue(value: String) {
        page = 1
        switch value {
            case "Activity".localized: selectedSort = sortByValues[1]
            case "Hot".localized: selectedSort = sortByValues[2]
            case "Votes".localized: selectedSort = sortByValues[3]
            default: selectedSort = sortByValues[0]
        }
        dataArray = []
        scrollToTop = true
        fetchQuestions()
    }
    
    private func fetchQuestions() {
        guard Reachability.sharedInstance.isReachable() else { return }
        Notifier.sharedInstance.showActivityIndicator(title: "Fetching Questions")
        NetworkEngine.sharedInstance.fetchQuestions(sortBy: selectedSort.1, page: page) { (data) in
            let fetchedData = (data as AnyObject).value(forKey: "items") as! [AnyObject]
            self.dataArray.append(contentsOf: fetchedData)
            self.tableView.reloadData()
            if self.scrollToTop {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.scrollToTop = false
            }
            Notifier.sharedInstance.removeNotifier()
        }
    }
    
    private func getNoDataCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "DefaultCell")
        cell.textLabel?.applyRegularTextTheme()
        cell.detailTextLabel?.applyVerySmallTextTheme()
        cell.textLabel?.text = "NoRecord".localized
        cell.detailTextLabel?.text = "CheckInternetInfo".localized
        cell.selectionStyle = .none
        return cell
    }
    
    func addRefreshControl() {
        refreshControl.tintColor = Colors.AppTheme
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching recent questions")
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshTableView() {
        dataArray = []
        page = 1
        scrollToTop = true
        fetchQuestions()
        refreshControl.endRefreshing()
    }
}
