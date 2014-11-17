//
//  StatusViewController.swift
//  Weibo_Swift
//
//  Created by cxjwin on 10/24/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import Foundation
import UIKit

class StatusViewController: UITableViewController {

	var statuses: NSMutableArray?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44.0
		
		tableView.registerNib(UINib(nibName: "TextStatusCell", bundle: nil), forCellReuseIdentifier: "TextStatusCell")
		tableView.registerNib(UINib(nibName: "RTTextStatusCell", bundle: nil), forCellReuseIdentifier: "RTTextStatusCell")
		tableView.registerNib(UINib(nibName: "ImageStatusCell", bundle: nil), forCellReuseIdentifier: "ImageStatusCell")
		tableView.registerNib(UINib(nibName: "RTImageStatusCell", bundle: nil), forCellReuseIdentifier: "RTImageStatusCell")

        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - data
    
    func fetchData() {
        let path = NSBundle.mainBundle().pathForResource("test_twenty_status", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers, error: nil)
        
        statuses = NSMutableArray()
        if let _json: NSDictionary = json as? NSDictionary {
            let array = _json["statuses"] as? NSArray
            for info in array as [NSDictionary] {
                let status: WBStatus = {
                    let _status = WBStatus()
                    _status.fillInDetailsWithJSONObject(info)
                    return _status
                }()
                
                statuses!.addObject(status)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return statuses!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
		let status = statuses![indexPath.row] as WBStatus
        
        var style: (hasImage: Bool, hasRetweetedStatus: Bool) = (false, false)
        
        if status.retweetedStatus != nil {
            style.hasRetweetedStatus = true
            let _status = status.retweetedStatus!
            if _status.picURLs.count > 0 {
                style.hasImage = true
            }
        } else {
            if status.picURLs.count > 0 {
                style.hasImage = true
            }
        }

        switch (style) {
        case (false, false):
			let cell = tableView.dequeueReusableCellWithIdentifier("TextStatusCell") as TextStatusCell
			cell.status = status
			return cell
			
        case (false, true):
			let cell = tableView.dequeueReusableCellWithIdentifier("RTTextStatusCell") as RTTextStatusCell
			cell.status = status
			return cell
			
        case (true, false):
			let cell = tableView.dequeueReusableCellWithIdentifier("ImageStatusCell") as ImageStatusCell
			cell.status = status
			return cell
			
        case (true, true):
			let cell = tableView.dequeueReusableCellWithIdentifier("RTImageStatusCell") as RTImageStatusCell
			cell.status = status
			return cell
			
        default :
            println("5")
        }
		
        return UITableViewCell()
    }

    // MARK: - UIScrollViewDelegate
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
