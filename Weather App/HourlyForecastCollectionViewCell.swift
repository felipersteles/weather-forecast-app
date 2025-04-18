//
//  HourlyForecastCollectionViewCell.swift
//  Weather App
//
//  Created by Felipe Teles on 11/04/25.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "HourlyForecast";
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hourLabel, iconImageView, temperatureLabel]);
        
        stackView.axis = .vertical;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.spacing = 4;
        stackView.layer.borderWidth = 1;
        stackView.layer.borderColor = UIColor.contrastColor?.cgColor;
        stackView.layer.cornerRadius = 20;
        stackView.isLayoutMarginsRelativeArrangement = true;
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        );
        
        return stackView;
    }();
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .contrastColor;
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold);
        label.textAlignment = .center;
        
        return label;
    }();
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .contrastColor;
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold);
        label.textAlignment = .center;
        
        return label;
    }();
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView();
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
        
        return imageView;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadData(time: String?, icon: UIImage?, temp: String?){
        hourLabel.text = time;
        iconImageView.image = icon;
        temperatureLabel.text = temp;
    }
    
    private func setupView(){
        setHierarchy();
        setConstraints();
    }
    
    private func setHierarchy(){
        contentView.addSubview(stackView);
    }
    
    private func setConstraints(){
        stackView.setConstraintsToParent(contentView);
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
}
