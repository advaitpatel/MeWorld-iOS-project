//
//  SnapMeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Patel, Advait Rajeshkumar on 3/1/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class SnapMeViewController: UIViewController {

    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
    
    @IBAction func signupOrLogin(_ sender: UIButton)
    {
        if usernameTextField.text == "" {
            
            errorLabel.text = "A username is required"
            
        }
        else
        {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: "password", block: { (user, error) in
                
                if error != nil {
                    
                    let user = PFUser()
                    
                    user.username = self.usernameTextField.text
                    user.password = "password"
                    
                    user.signUpInBackground(block: { (success, error) in
                        
                        if let error = error as? NSError {
                            
                            var errorMessage = "Signup failed - please try again later"
                            
                            if let errorString = error.userInfo["error"] as? String {
                                
                                errorMessage = errorString
                                
                            }
                            
                            self.errorLabel.text = errorMessage
                            
                        } else {
                            
                            self.performSegue(withIdentifier: "showUserTable", sender: self)
                            
                        }
                        
                        
                    })
                    
                    
                    
                } else {
                    
                    print ("Logged In")
                    
                    self.performSegue(withIdentifier: "showUserTable", sender: self)
                    
                }
                
                
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTable", sender: self)
            
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
