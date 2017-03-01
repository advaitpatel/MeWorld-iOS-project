//
//  DateMeUserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Patel, Advait Rajeshkumar on 2/27/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class DateMeUserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    
    @IBOutlet var userImage: UIImageView!
    
    
    @IBAction func updateProfileImage(_ sender: UIButton)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            userImage.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var genderSwitch: UISwitch!
    @IBOutlet var interestedInSwitch: UISwitch!
    @IBOutlet var errorLabel: UILabel!
    
    
    @IBAction func update(_ sender: UIButton)
    {
        PFUser.current()?["isFemale"] = genderSwitch.isOn
        
        PFUser.current()?["isInterestedInWomen"] = interestedInSwitch.isOn
        
        let imageData = UIImagePNGRepresentation(userImage.image!)
        
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData!)
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            
            
            if error != nil {
                
                var errorMessage = "Update failed - please try again"
                
                let error = error as? NSError
                
                if let parseError = error?.userInfo["error"] as? String {
                    
                    errorMessage = parseError
                    
                }
                
                self.errorLabel.text = errorMessage
                
            } else {
                
                print("Updated")
                
                self.performSegue(withIdentifier: "showSwipingViewController", sender: self)
                
            }
            
            
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            genderSwitch.setOn(isFemale, animated: false)
        }
        
        if let interestedIn = PFUser.current()?["isInterestedInWomen"] as? Bool {
            interestedInSwitch.setOn(interestedIn, animated: false)
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            photo.getDataInBackground(block: { (data, error) in
                if let imageData = data {
                    if let downloadedImage = UIImage(data: imageData) {
                        self.userImage.image = downloadedImage
                    }
                }
            })
        }
        
        let urlArray = ["https://filmykeeday.com/wp-content/uploads/2013/09/Norah-Jones-Indian-Actress-Hollywood.png",
                        "http://www.strongestinworld.com/wp-content/uploads/2016/04/8-Angelina-Julie.jpg",
                        "http://hdwidescreenwallpapers.com/wp-content/uploads/2014/08/hollywood-actress-hd-wallpapers-free-download.jpg",
                        "http://top101news.com/wp-content/uploads/2015/08/Scarlett-johansson-most-beautiful-hottest-hollywood-actress-2016.jpg",
                        "http://2.bp.blogspot.com/__RWIjMMpo1Y/TVARvOHqo-I/AAAAAAAAAd4/YWswujtS1KY/s1600/Kristen+Stewart+%252813%2529.jpg",
                        "http://newfashionweb.com/wp-content/uploads/2015/02/Latest-Hollywood-Actress-Beautiful-Hairstyle-Design-2015-For-Women.jpg",
                        "https://img.clipartfox.com/c68e56c72865e9806f1163f62c0a6333_hollywood-actresses-skin-hollywood-actress-clipart-cute_1600-1200.jpeg",
                        "http://www.themeshnews.com/wp-content/uploads/2016/03/Top-10-Most-Beautiful-Hollywood-Actresses-in-2016-Emma-Stone.jpg",
                        "http://alltoptens.com/wp-content/uploads/2013/11/Top-Ten-Most-Popular-Hollywood-Actresses-in-2013.jpg",
                        "https://www.vbestreviews.com/wp-content/uploads/2016/08/Jessica-Alba.png",
                        "http://top10best2016.com/wp-content/uploads/2015/10/Angelina-Jolie-1024x576.jpg",
                        "http://4.bp.blogspot.com/-0BuejZFdNic/UfS6dPH3z3I/AAAAAAAADPk/Cl0hipgC3ic/s1600/Hollywood+Actress+HD+Wallpapers+Megan+Fox.jpg",
                        "http://hdwidescreenwallpapers.com/wp-content/uploads/2014/08/hollywood-actress-hot-wallpaper.jpg",
                        "http://hdwallpapers88.com/wp-content/uploads/2016/10/Hollywood-Actress-Ali-Larter-HD-Wallpapers.jpg",
                        "http://www.cineforest.com/photos/lucy%20hale%20wearing%20alex%20perry%20dress%20photos/4.jpg",
                        "http://hdwallpapers88.com/wp-content/uploads/2016/10/Amy-Adams-Hollywood-Actress.jpg",
                        "http://www.wonderslist.com/wp-content/uploads/2015/11/Beautiful-Hollywood-Actress-Kate-Winslet.jpeg"]
        
        var counter = 0
        
        for urlString in urlArray {
            
            counter += 1
            
            let url = URL(string: urlString)!
            
            do {
                
                let data = try Data(contentsOf: url)
                
                let imageFile = PFFile(name: "photo.png", data: data)
                
                let user = PFUser()
                
                user["photo"] = imageFile
                
                user.username = String(counter)
                
                user.password = "password"
                
                user["isInterestedInWomen"] = false
                
                user["isFemale"] = true
                
                let acl = PFACL()
                
                acl.getPublicWriteAccess = true
                
                user.acl = acl
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if success {
                        
                        print("user signed up")
                        
                    }
                    
                })
                
            } catch {
                
                print("Could not get data")
                
            }
            
        }
 */
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            
            genderSwitch.setOn(isFemale, animated: false)
            
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool {
            
            interestedInSwitch.setOn(isInterestedInWomen, animated: false)
            
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            
            photo.getDataInBackground(block: { (data, error) in
                
                if let imageData = data {
                    
                    if let downloadedImage = UIImage(data: imageData) {
                        
                        self.userImage.image = downloadedImage
                        
                    }
                    
                }
                
                
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
