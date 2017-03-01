//
//  DateMeMatchesTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Patel, Advait Rajeshkumar on 3/1/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class DateMeMatchesTableViewCell: UITableViewCell {

    
    
    @IBOutlet var userIdLabel: UILabel!
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var messagesLabel: UILabel!
    
    @IBOutlet var messageTextField: UITextField!
    
    @IBAction func send(_ sender: UIButton)
    {
        print(userIdLabel.text)
        print(messageTextField.text)
        
        let message = PFObject(className: "Message")
        
        message["sender"] = PFUser.current()?.objectId!
        
        message["recipient"] = userIdLabel.text
        
        message["content"] = messageTextField.text
        
        message.saveInBackground()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
