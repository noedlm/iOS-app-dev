//
//  TableViewController.swift
//  flytr
//
//  Created by Angel De La Mora on 4/5/16.
//  Copyright © 2016 Noe Inc. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    
    let filters = [
        "Greenish",
        "reddish",
        "blueish",
        "brown",
        "grey",
        "not grey",
        "dark",
        "comic",
        "lumos",
        "pink",
        "ale",
        "noe",
        "yellow",
        "black",
        "white",
        "vintage",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = filters[indexPath.row]
        
        return cell
    }
}
