//
//  ListViewController.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import UIKit
import MBProgressHUD

class ListViewController: UIViewController {

    fileprivate var cityViewModel: CityDataModel?
    var availableCityData = [CityDetail]()

    var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK:- Constructing UITableView
        
        tableView = UITableView()
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl.addTarget(self, action: #selector(getListData), for: .valueChanged)
        tableView.refreshControl = refreshControl

        self.tableView.register(CityViewCell.self, forCellReuseIdentifier: String(describing: CityViewCell.self))
        
        // MARK:- TableView constraints
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.cityViewModel = CityDataModel()
        
        self.getListData()
    }
    
    // MARK:- Calling API to get the feed from JSON
    
    @objc func getListData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.cityViewModel?.getCityData(url: NetworkConstants.cityAPIUrl, parameters: [:], completion: { (error) in
            if error == nil {
                self.updateUI()
            } else {
                print("Unable to get the data")
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.refreshControl.endRefreshing()
            }
        })
    }

    // MARK:- updating UI based on the success in fetching data
    func updateUI() {
        DispatchQueue.main.async {
            self.title = self.cityViewModel?.city?.title
            self.availableCityData = self.cityViewModel?.city?.details?.filter{$0.title != nil} ?? []

            self.tableView.reloadData()
        }
    }
}

// MARK:- TableView Datasource methods

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableCityData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: CityViewCell.self), for: indexPath) as! CityViewCell
        cell.setData(cityDetailObj: self.availableCityData[indexPath.row])
        return cell
    }
}
