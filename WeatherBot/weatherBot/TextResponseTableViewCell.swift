//
//  TextResponseTableViewCell.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-16.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit

class TextResponseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        iconImageView.layer.cornerRadius = 16
        iconImageView.layer.masksToBounds = true
        
        labelContainerView.layer.cornerRadius = 8
        labelContainerView.layer.masksToBounds = true
        
        labelContainerView.backgroundColor = .clear
        labelContainerView.layer.borderColor = UIColor.blueBorder.cgColor
        labelContainerView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with message: Message) {
        
        iconImageView.image = UIImage(named: message.getImage())
        messageLabel.text = message.text
        messageLabel.textColor = .grey300
        
        let dateFormatterMessage = DateFormatter()
        dateFormatterMessage.setLocalizedDateFormatFromTemplate("hh:mm")
        timeLabel.text = dateFormatterMessage.string(from: message.date)
        timeLabel.textColor = .grey300
        
    }
}
