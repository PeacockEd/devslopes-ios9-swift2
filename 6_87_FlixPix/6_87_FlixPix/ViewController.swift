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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return CGFloat(165.0)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            deleteItem(indexPath)
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let button1 = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, indexPath) in
            self.deleteItem(indexPath)
        })
        button1.backgroundColor = UIColor(red: 20/255.0, green: 147/255.0, blue: 60/255.0, alpha: 1.0)
        /*
        let button2 = UITableViewRowAction(style: .Default, title: "Exuberant!", handler: { (action, indexPath) in
            print("button2 pressed!")
        })
        button2.backgroundColor = UIColor.redColor()
        return [button1, button2]
        */
        return [button1]
    }
    
    func deleteItem(indexPath:NSIndexPath)
    {
        let item = items[indexPath.row]
        if let context = item.managedObjectContext {
            context.deleteObject(item)
            do {
                try context.save()
            } catch {
                print("Unable to delete item")
            }
        }
        _items.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewItem" {
            if let detailVC = segue.destinationViewController as? ViewFlixPixItemVC {
                detailVC.flixPixItem = items[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
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

