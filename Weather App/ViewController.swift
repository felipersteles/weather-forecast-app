//
//  ViewController.swift
//  Weather App
//
//  Created by Felipe Teles on 11/04/25.
//

import UIKit


class ViewController: UIViewController {

    // Create the view in lazy mode (only in the first use)
    private lazy var backgroundView: UIImageView = {
        
        let imageView = UIImageView(frame: .zero);
        imageView.image = UIImage(named: "background");
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        return imageView;
    }();
    
    private lazy var headerView: UIView = {
        
        let header = UIView(frame: .zero);
        
        header.translatesAutoresizingMaskIntoConstraints = false;
        header.backgroundColor = .white;
        header.layer.cornerRadius = 20;
        
        return header;
    }();
    
    private lazy var cityLabel: UILabel = {
        
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 20);
        label.text = "São José de Ribamar";
        label.textAlignment = .center;
        label.textColor = UIColor(named: "primaryColor")
        
        return label;
    }();
    
    private lazy var temperatureLabel: UILabel = {
        
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 70, weight: .bold);
        label.text = "25ºC";
        label.textAlignment = .left;
        label.textColor = UIColor(named: "primaryColor")
        
        return label;
    }();
    
    private lazy var wheaterIcon: UIImageView = {
        let image = UIImageView();
        
        image.image = UIImage(named: "sunIcon");
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false;
        
        return image;
    }();
    
    // Executed once
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView();
    }

    // Executed when the view appear (every change view)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Executed before viewDidAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Executed after viewDidAppear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // Setup the view
    private func setupView(){
        view.backgroundColor = UIColor.systemBlue;

        setHierarchy();
        setConstraints();
    }
    
    // Add the custom views
    private func setHierarchy(){
        view.addSubview(backgroundView);
        
        view.addSubview(headerView);
        headerView.addSubview(cityLabel);
        headerView.addSubview(temperatureLabel);
        headerView.addSubview(wheaterIcon);
    }
    
    // Responsive
    private func setConstraints(){
        // background
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]);
        
        // header
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 170)
        ]);
        
        // label header
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            wheaterIcon.heightAnchor.constraint(equalToConstant: 86),
            wheaterIcon.widthAnchor.constraint(equalToConstant: 86),
            wheaterIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            wheaterIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            wheaterIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15),
        ]);
    }
}

