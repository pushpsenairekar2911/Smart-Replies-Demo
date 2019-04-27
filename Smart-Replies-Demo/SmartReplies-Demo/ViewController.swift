//
//  ViewController.swift
//  SmartReplies-Demo
//
//  Created by pushpsen airekar on 27/04/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var suggetionsView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var getReplies: UIButton!
    
    var conversation: [TextMessage] = []
    var suggestions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    @IBAction func getSmartReplies(_ sender: Any) {
        
        
        let message = TextMessage(
            text: messageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "default",
            timestamp: Date().timeIntervalSince1970,
            userID: "superhero1",
            isLocalUser: false)
        
        conversation.append(message)
        print("conversations: \(conversation)")
        
        let naturalLanguage = NaturalLanguage.naturalLanguage()
        
        naturalLanguage.smartReply().suggestReplies(for: conversation) { result, error in
            guard error == nil, let result = result else {
                return
            }
            if (result.status == .notSupportedLanguage) {
                self.suggetionsView.isHidden = true
                DispatchQueue.main.async{
                    self.messageTextField.text = ""
                    self.getReplies.setTitle("Not Supported", for: .normal)
                    self.getReplies.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.getReplies.setTitle("Get Replies", for: .normal)
                    self.getReplies.backgroundColor = #colorLiteral(red: 0, green: 0.7316704605, blue: 0.8899335265, alpha: 1)
                }
                
            } else if (result.status == .success) {
                
                print("Output is: \(result.suggestions)")
                
                for m in result.suggestions{
                    self.suggestions.append(m.text)
                    print("messages is: \(m.text)")
                    
                }
                
                if self.suggestions.isEmpty {
                    self.suggetionsView.isHidden = true
                }else{
                    self.suggetionsView.isHidden = false
                }

                self.button1.setTitle(self.suggestions[0], for: .normal)
                self.button2.setTitle(self.suggestions[1], for: .normal)
                self.button3.setTitle(self.suggestions[2], for: .normal)
   
            }
        }
        self.suggestions.removeAll()
        self.conversation.removeAll()
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        
        if let buttonTitle = (sender as AnyObject).title(for: .normal) {
           messageTextField.text = buttonTitle
        }
        
        
    }
    
    @IBAction func button2Pressed(_ sender: Any) {
        
        if let buttonTitle = (sender as AnyObject).title(for: .normal) {
            messageTextField.text = buttonTitle
        }
    }
    
    @IBAction func button3Pressed(_ sender: Any) {
        
        if let buttonTitle = (sender as AnyObject).title(for: .normal) {
            messageTextField.text = buttonTitle
        }
    }
 
}

extension UIView {
    // Specifies Corner Radius for the UIView directly from Storyboard
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}

