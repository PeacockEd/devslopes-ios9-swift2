//
//  ViewController.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/7/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var _items = [FlixPixItem]()
    
    
    var items:[FlixPixItem] {
        get {
            return _items
        }
        set {
            _items = newValue
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        fetchAndSetResults()
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCellWithIdentifier("FlixPixTableCell") as? FlixPixTableCell {
            cell.configureCell(items[indexPath.row])
            return cell
        } else {
            return FlixPixTableCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    private func fetchAndSetResults()
    {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "FlixPixItem")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.items = results as! [FlixPixItem]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

