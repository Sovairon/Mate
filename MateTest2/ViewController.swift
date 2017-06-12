//
//  ViewController.swift
//  MateTest2
//
//  Created by Eren Atas on 08/06/2017.
//  Copyright © 2017 Eren Atas. All rights reserved.


// LOGIN VIEW CONTROLLER

import UIKit
import Pastel
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth



class ViewController: UIViewController, LoginButtonDelegate {
    
    
    //Constants
    let loginToList = "segueTest"
    let bounds = UIScreen.main.bounds
    


    //Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    //Actions
    @IBAction func loginDidTouch(_ sender: Any) {
        performSegue(withIdentifier: loginToList, sender: nil) //XXXXXXXXXX
    }
    @IBAction func signUpDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Cancel", style: .default){
            action in
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField{ textEmail in
            textEmail.placeholder = "Enter your email."
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pastelAnimation()
        
        let fbButton = LoginButton(readPermissions: [.publicProfile, .email, .userFriends])
        fbButton.delegate = self
        //fbButton.center = view.center
        fbButton.frame.origin = CGPoint(x: 0.5*self.view.frame.width - 90, y: 0.7*self.view.frame.height) //XXXXXXXXX
    
        view.addSubview(fbButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print(result)
        print("DidCompleteLogin")
        performSegue(withIdentifier: loginToList, sender: nil) //XXXXXXXXXX

        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("DidLogOut")
        
        
    }
    
    func fetchProfile(){
        
        let parameters = ["fields": "email, first_name, last_name, id"]
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        self.firebaseLogin(credential)
        
        GraphRequest(graphPath: "me",
                     parameters: parameters,
                     accessToken: AccessToken.current,
                     httpMethod: .GET,
                     apiVersion: .defaultVersion).start { (urlResponse, requestResult) in
                        
                        switch requestResult {
                        case .failed(let error):
                            print(error)
                            break
                        case .success(let graphResponse):
                            
                            if let responseDict = graphResponse.dictionaryValue {
                                let firstName = responseDict["first_name"] as? String
                                let lastName = responseDict["last_name"] as? String
                                
                                
                                //print(firstName, " ", lastName)
                                //let email = responseDict["id"] as? String
                                
                                
                                //self.nameLabel.morphingEffect = LTMorphingEffect.scale
                                //self.nameLabel.morphingDuration = 2.0
                                //self.nameLabel.text = "Welcome,"
                                //let dispatchTime = DispatchTime.now() + .seconds(3)
                                //DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                                  //  self.nameLabel.text = "\(firstName!) \(lastName!)"
                                    //self.nameLabel.text = "\(email!)"
                                //}
                            }
                            break
                        }
        }
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        if let user = Auth.auth().currentUser {
            // [START link_credential]
            user.link(with: credential) { (user, error) in
                // [START_EXCLUDE]
                
                if let error = error {
                    print(error)
                    return
                }
                
                
                // [END_EXCLUDE]
            }
            // [END link_credential]
        } else {
            // [START signin_credential]
            Auth.auth().signIn(with: credential) { (user, error) in
                // [START_EXCLUDE]
                
                // [END_EXCLUDE]
                if let error = error {
                    // [START_EXCLUDE]
                    print(error)
                }
                // [END signin_credential]
                // Merge prevUser and currentUser accounts and data
                // ...
                
            }
        }
    }
    
    func pastelAnimation(){
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        
        //pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
        //UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
        //UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
        //UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
        //UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
        //UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
        //UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0),
        //])
        
        
        pastelView.setColors([UIColor(red:0.93, green:0.43, blue:0.63, alpha:1.0),
                              UIColor(red:0.93, green:0.55, blue:0.41, alpha:1.0),
                              UIColor(red:0.98, green:0.83, blue:0.14, alpha:1.0),
                              UIColor(red:0.88, green:0.31, blue:0.68, alpha:1.0)])
        
        pastelView.startAnimation()
        
        view.insertSubview(pastelView, at: 0)
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

