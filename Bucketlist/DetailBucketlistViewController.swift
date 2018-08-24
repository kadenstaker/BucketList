//
//  DetailBucketlistViewController.swift
//  Bucketlist
//
//  Created by Kaden Staker on 8/23/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class DetailBucketlistViewController: UIViewController {

    // Segue landing pad
    
    var bucketListItem: BucketListItem?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateViews() {
        guard let bucketListItem = bucketListItem else {return}
        
        titleTextField.text = bucketListItem.title
        ageTextField.text = "\(bucketListItem.age)"
        bodyTextView.text = bucketListItem.description
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard titleTextField.text != nil else {return}
        
        // Get access to bucketlist item
        // All 3 conditions must return true or guard will stop the save button function
        guard let title = titleTextField.text,
            let ageString = ageTextField.text,
            // Can't convert age constant to type Int on the same line
            let age: Int = Int(ageString) ?? 0,
            let description = bodyTextView.text else {return}
        
        
        if let bucketListItem = bucketListItem {
            BucketListItemController.shared.update(bucketListItem: bucketListItem, newTitle: title, newAge: age, newDescription: description)
        } else {
            // Access the shared class
            BucketListItemController.shared.create(title: title, age: age, description: description)
        }
        // Pop the top view off of the navigation controller
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        // Set each text field to a blank string once the clear button is tapped
        titleTextField.text = ""
        ageTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    
}
