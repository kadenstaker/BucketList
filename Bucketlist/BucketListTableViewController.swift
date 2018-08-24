//
//  BucketListTableViewController.swift
//  Bucketlist
//
//  Created by Kaden Staker on 8/23/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Show text to the user's view when the save button is tapped
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Access the amount of bucketlist items for the number of rows
        return BucketListItemController.shared.bucketList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketListCell", for: indexPath)
        // Access the index path
        let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
        // Move text label into the bucketlist item title
        cell.textLabel?.text = bucketListItem.title
        // Move the detail text into the age section
        cell.detailTextLabel?.text = "\(bucketListItem.age)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
        BucketListItemController.shared.delete(bucketListItem: bucketListItem)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check segue identifier
        if segue.identifier == "toDetailVC" {
            // Get destination from the segue
            // Pass destination as your VC class
            let destinationVC = segue.destination as? DetailBucketlistViewController
            // Get indexpath for whatever row the user selected
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            // Get object from your source of truth by indexing from the indexpath from just barely
            let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
            // Create landing pad in detailVC class
            // Pass info to the landing pad
            destinationVC?.bucketListItem = bucketListItem
            
        }
    }
}
