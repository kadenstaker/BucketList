//
//  BucketListItemController.swift
//  Bucketlist
//
//  Created by Kaden Staker on 8/23/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation

class BucketListItemController {
    
    
    // Shared instance (one to rule them all)
    static let shared = BucketListItemController()
    
    // Source of Truth
    var bucketList: [BucketListItem] = []
    
    // CRUD
    
    // Create
    func create(title: String, age: Int, description: String) {
        // Instantiate (create instance of class object)
        let bucketListItem = BucketListItem(title: title, age: age, description: description)
        // Append to bucketlist
        bucketList.append(bucketListItem)
        // Call saveToPersistentStore
        saveToPersistentStore()
    }
    // Don't worry about read in this instance (user can see all data in their bucketlist)
    
    // Update
    func update(bucketListItem: BucketListItem, newTitle: String, newAge: Int, newDescription: String) {
        // We just want to change properties, so
        bucketListItem.title = newTitle
        bucketListItem.age = newAge
        bucketListItem.description = newDescription
        // Call saveToPersistentStore
        saveToPersistentStore()
    }
    
    // Destroy
    func delete(bucketListItem: BucketListItem) {
        // Implement equatable (in BucketListItem class swift file)
        // Index what we want to remove
        
        // THIS FUNCTION IS ONLY AVAILABLE IF YOU CONFORM TO EQUATABLE
        // Unwrap index with guard
        guard let index = bucketList.index(of: bucketListItem) else {return}
        // Feed index into remove function
        bucketList.remove(at: index)
        // Call saveToPersistentStore
        saveToPersistentStore()
    }
    
    
    // MARK: - Persistence
    
    // Choo-choo train
    
    // Building the track
    func fileURL() -> URL {
        // Track (Apple's API - Application Programming Interface)
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Location, first one (0)
        let documentsDirectory = paths[0]
        // Destination (station)
        let fileName = "bucketList.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        print(fullURL)
        return fullURL
    }
    
    // Load up the train
    func saveToPersistentStore(){
        // Packaging everything on the train
        let encoder = JSONEncoder()
        do {
            // Boxing things into coal or a form that they can be saved
            let data = try encoder.encode(bucketList)
            print(data)
            // Sending train to bucketList.json destination station
            try data.write(to: fileURL())
        } catch {
            // If it doesn't work, catch the error and let me know what it is (poop emoji)
            print("💩 There was an error Saving to Persistent Store \(error) \(error.localizedDescription) 💩")
        }
    }
    
    // Needs train to come back
    func loadsFromPersistentStore() -> [BucketListItem] {
        do {
            // Checking if there's a train full of coal
            let data = try Data(contentsOf: fileURL())
            // Decoder unpacks coal or boxes that were saved
            let decoder = JSONDecoder()
            let bucketListItems = try decoder.decode([BucketListItem].self, from: data)
            // Unpack the coal of type
            return bucketListItems
        } catch {
            // If can't be unpacked, catch
            print("💩 There was an error loading to Persistent Store \(error) \(error.localizedDescription) 💩")
        }
        return []
    }
}
