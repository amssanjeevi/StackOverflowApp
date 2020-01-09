//
//  QuestionsTableCell.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

class QuestionsTableCell: UITableViewCell {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var totalAnswersLabel: UILabel!
    @IBOutlet weak var totalViewsLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var askedByLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        votesLabel.applyCornerRadius(of: Constants.Sizing.StandardCornerRadius)
        totalAnswersLabel.applyCornerRadius(of: Constants.Sizing.StandardCornerRadius)
        totalViewsLabel.applyCornerRadius(of: Constants.Sizing.StandardCornerRadius)
        votesLabel.addLineBreak(lineCount: 2)
        totalAnswersLabel.addLineBreak(lineCount: 2)
        totalViewsLabel.addLineBreak(lineCount: 2)
        votesLabel.addBorder(borderColor: Colors.Border)
        totalAnswersLabel.addBorder(borderColor: Colors.Border)
        totalViewsLabel.addBorder(borderColor: Colors.Border)
        questionTextView.addStandardTextTheme()
        timeStampLabel.applyVerySmallTextTheme()
        askedByLabel.applyVerySmallTextPrimaryTheme()
    }
    
    func populateView(with data: AnyObject?) {
        votesLabel.attributedText(
            firstText: value(from: data, for: Constants.Items.Score, dataType: .Number),
            firstTextFont: (Constants.FontSize.Regular, .regular),
            firstTextColor: Colors.LightTextColor,
            secondText: "\n" + "Votes".localized,
            secondTextFont: (Constants.FontSize.VerySmall, .semibold),
            secondTextColor: Colors.LightTextColor
        )
        totalAnswersLabel.attributedText(
            firstText: value(from: data, for:  Constants.Items.AnswerCount, dataType: .Number),
            firstTextFont: (Constants.FontSize.Regular, .regular),
            firstTextColor: Colors.LightTextColor,
            secondText: "\n" + "Ans".localized,
            secondTextFont: (Constants.FontSize.VerySmall, .semibold),
            secondTextColor: Colors.LightTextColor
        )
        totalViewsLabel.attributedText(
            firstText: value(from: data, for:  Constants.Items.ViewCount, dataType: .Number),
            firstTextFont: (Constants.FontSize.Regular, .regular),
            firstTextColor: Colors.LightTextColor,
            secondText: "\n" + "Views".localized,
            secondTextFont: (Constants.FontSize.VerySmall, .semibold),
            secondTextColor: Colors.LightTextColor
        )
        timeStampLabel.text = value(from: data, for: Constants.Items.CreationDate, dataType: .Number).timeAgo
        askedByLabel.text = value(from: data?.value(forKey: Constants.Items.Owner) as AnyObject, for: Constants.OwnerFields.DisplayName, dataType: .Text)
        questionTextView.text = value(from: data, for: Constants.Items.Title, dataType: .Text)
        if value(from: data, for: Constants.Items.IsAnswered, dataType: .Boolean) == "Yes" {
            totalAnswersLabel.addBorder(borderColor: Colors.DarkGreen)
            totalAnswersLabel.textColor = Colors.DarkGreen
        } else {
            totalAnswersLabel.addBorder(borderColor: Colors.LightTextColor)
            totalAnswersLabel.textColor = Colors.LightTextColor
        }
    }
    
    private func value(from data: AnyObject?, for key: String, dataType: DataType) -> String {
        switch dataType {
            case .Number: return (data?.value(forKey: key) as? NSNumber)?.stringValue ?? ""
            case .Boolean: return (data?.value(forKey: key) as? Bool ?? false) ? "Yes" : "No"
            default: return data?.value(forKey: key) as? String ?? ""
        }
    }
}
