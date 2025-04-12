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
        label.textAlignment = .center;
        label.textColor = UIColor(named: "primaryColor")
        
        return label;
    }();
    
    private lazy var temperatureLabel: UILabel = {
        
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 65, weight: .bold);
        label.textAlignment = .left;
        label.textColor = UIColor(named: "primaryColor")
        
        return label;
    }();
    
    private lazy var wheaterIcon: UIImageView = {
        let image = UIImageView();
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false;
        
        return image;
    }();
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Umidade";
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        label.textColor = UIColor(named: "contrastColor");
        
        return label;
    }();
    
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        label.textColor = UIColor(named: "contrastColor");
        
        return label;
    }();
    
    private lazy var humidityStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel]);
        
        stackView.axis = .horizontal;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        return stackView;
    }();
    
    private lazy var windLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Vento";
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        label.textColor = UIColor(named: "contrastColor");
        
        return label;
    }();
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold);
        label.textColor = UIColor(named: "contrastColor");
        
        return label;
    }();
    
    private lazy var windStackView = {
        let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel]);
        
        stackView.axis = .horizontal;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        return stackView;
    }();
    
    private lazy var statsStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView]);
        
        stackView.axis = .vertical;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.spacing = 5;
        stackView.backgroundColor = UIColor(named: "softGray");
        stackView.layer.cornerRadius = 10;
        stackView.isLayoutMarginsRelativeArrangement = true;
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 12,
            leading: 24,
            bottom: 12,
            trailing: 24
        );
        
        return stackView;
    }();
    
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = UIColor(named: "contrastColor");
        label.text = "PREVISÃO POR HORA"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold);
        label.textAlignment = .center;
        
        return label;
    }();
    
    private lazy var hourlyCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal;
        layout.itemSize = CGSize(width: 67, height: 84);
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12);
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.backgroundColor = .clear;
        collectionView.dataSource = self;
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.indentifier)
        
        return collectionView;
    }();
    
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = UIColor(named: "contrastColor");
        label.text = "PRÓXIMOS DIAS"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold);
        label.textAlignment = .center;
        
        return label;
    }();
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView();
        
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.backgroundColor = .clear;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier);
        tableView.separatorColor = .contrastColor;
        
        return tableView;
    }();
    
    private let service = WeatherService();
    private var city = City(lat: "-2.56318", long: "-44.0626", name: "São José de Ribamar");
    private var forecastResponse: ForecastResponse?;
    
    // Executed once
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView();
        fetchData();
    }
    
    private func fetchData(){
        service.fetchData(city: city, {[weak self] response in
            self?.forecastResponse = response;
            DispatchQueue.main.async{
                self?.loadData()
            }
            
        });
    }
    
    private func loadData(){
        cityLabel.text = city.name;
        
        temperatureLabel.text = "\(Int(forecastResponse?.current?.temp ?? 0))°C";
        humidityValueLabel.text = "\(forecastResponse?.current?.humidity ?? 0)mm";
        windValueLabel.text = "\(forecastResponse?.current?.windSpeed ?? 0)km/h";
        wheaterIcon.image = UIImage(named: forecastResponse?.current?.weather.first?.icon ?? "");
        
        if forecastResponse?.current?.dt.isDayTime() ?? true {
            backgroundView.image = UIImage(named: "background");
        } else{
            backgroundView.image = UIImage(named: "background-night");
        }
        
        hourlyCollectionView.reloadData();
        dailyForecastTableView.reloadData();
    }
    
    // Setup the view
    private func setupView(){
//        view.backgroundColor = UIColor.systemBlue;

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
        
        view.addSubview(statsStackView);
        
        view.addSubview(hourlyForecastLabel);
        view.addSubview(hourlyCollectionView);
        
        view.addSubview(dailyForecastLabel);
        view.addSubview(dailyForecastTableView);
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
            headerView.heightAnchor.constraint(equalToConstant: 150)
        ]);
        
        // label header
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 70),
            wheaterIcon.heightAnchor.constraint(equalToConstant: 86),
            wheaterIcon.widthAnchor.constraint(equalToConstant: 86),
            wheaterIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            wheaterIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            wheaterIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15),
        ]);
        
        // humidity box
        NSLayoutConstraint.activate([
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 200),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]);
        
        // hourly wheater section
        NSLayoutConstraint.activate([
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 24),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            hourlyForecastLabel.widthAnchor.constraint(equalToConstant: 200),
            hourlyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]);
        
        // daily Table weather
        NSLayoutConstraint.activate([
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 24),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            dailyForecastLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            dailyForecastLabel.widthAnchor.constraint(equalToConstant: 200),
            dailyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 22),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]);
    }
}

extension ViewController: UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastResponse?.daily.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell();
        };
        
        let forecast = forecastResponse?.daily[indexPath.row];
        
        cell.loadData(
            weekDay: forecast?.dt.toWeekdayName(),
            min: forecast?.temp.min.toCelsius(),
            max: forecast?.temp.max.toCelsius(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? "")
        )
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastResponse?.hourly.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.indentifier, for: indexPath) as? HourlyForecastCollectionViewCell else{
            return UICollectionViewCell();
        };
        
        let forecast = forecastResponse?.hourly[indexPath.row];
        
        cell.loadData(
            time: forecast?.dt.toHourFormat(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? ""),
            temp: forecast?.temp.toCelsius()
        )
        
        return cell;
    }
    
    
}
