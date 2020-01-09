//
//  HomeViewController.swift
//  StackOverflowApp
//
//  Created by admin on 06/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

protocol ViewAnswerDelegate {
    func showAnswerForQuestion(at indexPath: Int, data: AnyObject)
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let QuestionCellIdentifier = "QuestionsTableCell"
    
    var dataArray: [AnyObject] = []
    var sortByValues: [String] = ["Latest", "Activity", "Hot", "Votes"]
    var answerDelegate: ViewAnswerDelegate!
    var sortBy = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
        fetchQuestions(sortBy: "creation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.BackgroundColor
        sortBy = sortByValues.first!
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
        var alertActions = sortByValues.map { UIAlertAction(title: $0.localized, style: .default, handler: { (action) in
            self.sortBy = action.title!
            self.sortQuestionsBySelectedValue()
        }) }
        alertActions.append(UIAlertAction(title: "Cancel".localized, style: .destructive, handler: { (action) in
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }))
        addAlertViewController(title: "SortBy".localized, message: "SortQuestionsBy".localized, selected: sortBy, alertActions: alertActions, style: .actionSheet)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.constructQuestionCell(identifier: QuestionCellIdentifier, indexPath: indexPath, data:  dataArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answerDelegate.showAnswerForQuestion(at: indexPath.row, data: "e" as AnyObject)
    }
    
    func sortQuestionsBySelectedValue() {
        var sortKey = ""
        switch sortBy.localized {
            case "Activity".localized: sortKey = "activity"
            case "Hot".localized: sortKey = "hot"
            case "Votes".localized: sortKey = "votes"
            default: sortKey = "creation"
        }
        fetchQuestions(sortBy: sortKey)
    }
    
    private func fetchQuestions(sortBy: String) {
        NetworkEngine.sharedInstance.fetchQuestions(sortBy: sortBy) { (data) in
            self.dataArray = (data as AnyObject).value(forKey: "items") as! [AnyObject]
            self.tableView.reloadData()
            self.chumma()
        }
    }
    
    func chumma() {
        let url = "https://stackoverflow.com/oauth?client_id=16977&redirect_uri=https://stackexchange.com"
        SessionsManager.sharedInstance.GET(urlString: url, success: { (data) in
            
        }, failure: { (error) in
            
        }, isJSON: false)
    }
}
