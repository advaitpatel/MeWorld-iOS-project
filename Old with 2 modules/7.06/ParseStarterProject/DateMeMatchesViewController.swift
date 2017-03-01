//
//  DateMeMatchesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Patel, Advait Rajeshkumar on 2/27/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class DateMeMatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var images = [UIImage]()
    var userIds = [String]()
    var messages = [String]()
    
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let query = PFUser.query()
        query?.whereKey("accepted", contains: PFUser.current()?.objectId)
        
        query?.whereKey("objectId", containedIn: PFUser.current()?["accepted"] as! [String])
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        let imageFile = user["photo"] as! PFFile
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            
                            if let imageData = data {
                                
                                let messageQuery = PFQuery(className: "Message")
                                
                                messageQuery.whereKey("recipient", equalTo: (PFUser.current()?.objectId!)!)
                                
                                messageQuery.whereKey("sender", equalTo: user.objectId!)
                                
                                messageQuery.findObjectsInBackground(block: { (objects, error) in
                                    
                                    var messageText = "No message from this user."
                                    
                                    if let objects = objects {
                                        
                                        for message in objects {
                                            
                                            if let messageContent = message["content"] as? String {
                                                
                                                messageText = messageContent
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    self.messages.append(messageText)
                                    
                                    self.images.append(UIImage(data: imageData)!)
                                    
                                    self.userIds.append(user.objectId!)
                                    
                                    self.tableView.reloadData()
                                    
                                    
                                })
                                
                            }
                            
                            
                        })
                        
                    }
                    
                }
                
            }
            
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DateMeMatchesTableViewCell
        
        cell.userImageView.image = images[indexPath.row]
        
        cell.messagesLabel.text = "You haven't received a message yet"
        
        cell.userIdLabel.text = userIds[indexPath.row]
        
        cell.messagesLabel.text = messages[indexPath.row]
        
        return cell
        
        
    }
    

}
