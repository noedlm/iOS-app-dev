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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(filters[indexPath.row])
        tableView.cellForRowAtIndexPath(indexPath)?.selectionStyle = UITableViewCellSelectionStyle.None
        tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.orangeColor()
        tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.backgroundColor = UIColor.orangeColor()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.purpleColor()
        tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.textColor = UIColor.whiteColor()
        tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.backgroundColor = UIColor.purpleColor()
    }
}
