//
//  DailyTableViewCell.swift
//  Weather App
//
//  Created by Felipe Teles on 11/04/25.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    static let identifier: String = "DailyForecast"
    
    private lazy var day: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Sáb"
        label.textColor = .contrastColor;
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        
        return label;
    }();
    
    private lazy var minTemperatura: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "min 25ºC"
        label.textColor = .contrastColor;
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        
        return label;
    }();
    
    private lazy var maxTemperatura: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "max 30ºC"
        label.textColor = .contrastColor;
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        
        return label;
    }();
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView();
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
        
        return imageView;
    }();
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [day,
                                                       iconImageView,
                                                       minTemperatura,
                                                       maxTemperatura]);
        
        stackView.axis = .horizontal;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.isLayoutMarginsRelativeArrangement = true;
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16);
        stackView.spacing = 15;
        
        return stackView;
    }();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        setupView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(weekDay: String?, min: String?, max: String?, icon: UIImage?){
        day.text = weekDay;
        
        minTemperatura.text = "min \(min ?? "")";
        maxTemperatura.text = "max \(max ?? "")";
        iconImageView.image = icon;
    }
    
    private func setupView(){
        backgroundColor = .clear;
        selectionStyle = .none;
        
        setHierarchy();
        setConstraints()
    };
    
    private func setHierarchy(){
        contentView.addSubview(stackView);
    };
    
    private func setConstraints(){
        stackView.setConstraintsToParent(contentView);
        NSLayoutConstraint.activate([
            day.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    };
}

