//
//  ForecastResponsTableViewCell.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-17.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import SnapKit

class ForecastResponseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastWrapperView: UIView!
    
    let numberOfDay = 5
    
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
        
        // Configure the view for the selected state
    }
    
    func configure(with message: Message) {
        
        //general
        iconImageView.image = UIImage(named: message.getImage())
        let dateFormatterMessage = DateFormatter()
        dateFormatterMessage.setLocalizedDateFormatFromTemplate("hh:mm")
        timeLabel.text = dateFormatterMessage.string(from: message.date)
        timeLabel.textColor = .grey300
        
        ///header
        cityLabel.text = message.forecast!.city
        let dateFormatterHeader = DateFormatter()
        dateFormatterHeader.setLocalizedDateFormatFromTemplate("MMMM dd yyyy")
        dateLabel.text = dateFormatterHeader.string(from: message.forecast!.date)
        dateLabel.font = dateLabel.font.withSize(12)
        weatherIconImageView.image = message.forecast!.weatherIcon.image!
        let sepView = UIView()
        sepView.backgroundColor = UIColor.blueBorder.withAlphaComponent(0.5)
        labelContainerView.addSubview(sepView)
        sepView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(labelContainerView)
            make.left.equalTo(labelContainerView)
            make.height.equalTo(1)
            make.bottom.equalTo(forecastWrapperView.snp.top)
        }
        
        //forecast Days
        let mainStackView = UIStackView(arrangedSubviews: createForecastDaysList(message.forecast!.forecastDays))
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .fillEqually
        
        forecastWrapperView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(forecastWrapperView)
            make.right.equalTo(forecastWrapperView)
            make.left.equalTo(forecastWrapperView)
            make.top.equalTo(forecastWrapperView)
        }
        
    }
    
    func createForecastDaysList(_ forecastDays: [ForecastDay]) -> [UIView] {
        
        var forecastDayViews = [UIView]()
        
        for (index, forecastDay) in forecastDays.enumerated() {
            if(index < numberOfDay) {
                let forecastDayView = createForecastDayView(forecastDay)
                forecastDayViews.append(forecastDayView)
            }
        }
        
        return forecastDayViews
    }
    
    func createForecastDayView(_ forecastDay: ForecastDay) -> UIView {
        
        let leftView = UIView()
        let centerView = UIView()
        let rightView = UIView()
        
        //left
        let dateLabel = UILabel()
        let dateFormatterLeft = DateFormatter()
        dateFormatterLeft.setLocalizedDateFormatFromTemplate("MMM dd")
        dateLabel.text = dateFormatterLeft.string(from: forecastDay.date)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = dateLabel.font.withSize(14)
        leftView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(leftView)
            make.right.equalTo(leftView)
            make.left.equalTo(leftView)
            make.top.equalTo(leftView)
        }
        
        //center
        let iconImageView = UIImageView()
        iconImageView.image = forecastDay.weatherIcon.image!
        iconImageView.contentMode = .scaleAspectFit
        centerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(centerView)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        let sepLeftView = UIView()
        sepLeftView.backgroundColor = UIColor.blueBorder.withAlphaComponent(0.5)
        centerView.addSubview(sepLeftView)
        sepLeftView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(centerView)
            make.bottom.equalTo(centerView)
            make.top.equalTo(centerView)
            make.width.equalTo(1)
        }
        let sepRightView = UIView()
        sepRightView.backgroundColor = UIColor.blueBorder.withAlphaComponent(0.5)
        centerView.addSubview(sepRightView)
        sepRightView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(centerView)
            make.bottom.equalTo(centerView)
            make.top.equalTo(centerView)
            make.width.equalTo(1)
        }
        
        //right
        let temperatureLabel = UILabel()
        temperatureLabel.text = forecastDay.max.degree.description
        temperatureLabel.textColor = .white
        temperatureLabel.textAlignment = .right
        temperatureLabel.font = temperatureLabel.font.withSize(14)
        rightView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(rightView)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        
        let measureLablel = UILabel()
        measureLablel.text = forecastDay.max.measure
        measureLablel.textColor = .mainGreen
        measureLablel.textAlignment = .left
        measureLablel.font = measureLablel.font.withSize(8)
        rightView.addSubview(measureLablel)
        measureLablel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(rightView).offset(-2)
            make.height.equalTo(10)
            make.width.equalTo(10)
            make.left.equalTo(temperatureLabel.snp.right).offset(2)
        }
        
        let views = [leftView, centerView, rightView]
        let DayStackView = UIStackView(arrangedSubviews: views)
        
        DayStackView.translatesAutoresizingMaskIntoConstraints = false
        DayStackView.axis = .horizontal
        DayStackView.spacing = 0
        DayStackView.distribution = .fillEqually
        
        return DayStackView
        
    }
}
