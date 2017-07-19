//
//  ViewController.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerButton: UIButton!
    
    @IBOutlet weak var pointingFingerLabel: UILabel!
    
    
    let dimLevel: CGFloat = 0.5
    let dimSpeed: Double = 0.5
    
    var question: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 201/255, green: 69/255, blue: 53/255, alpha: 1.0)
        
        prepareIntroLabel()
        questionTextField.delegate = self
        setupGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: Dimmable{
    @IBAction func unwindFromPopupView(segue: UIStoryboardSegue){
        dim(direction: .down, speed: dimSpeed)
    }
    
    func presentAnswer(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Popup__View") as? PopupViewController else { return }
        vc.question = question
        dim(direction: .up, alpha: dimLevel, speed: dimSpeed)
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController{
    func prepareIntroLabel(){
        let formattedString = NSMutableAttributedString()
        introLabel.attributedText = formattedString.normal(text: "Ask a ").bold(text: "yes", size: 17, weight: UIFontWeightBold).normal(text: " or ").bold(text: "no", size: 17, weight: UIFontWeightBold).normal(text: " question")
    }
    
    @IBAction func didPressPresentAnswer(sender: AnyObject){
        guard questionTextField.text != "" else { return }
        question = questionTextField.text
        questionTextField.text = ""
        questionTextField.resignFirstResponder()
        presentAnswer()
    }
    
    @IBAction func didPressFavorites(sender: AnyObject){
        guard let nav = storyboard?.instantiateViewController(withIdentifier: "Fav__Nav") as? UINavigationController else {
            // TODO: - No favorites
            return
        }
        
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func didPressInfo(sender: AnyObject){
        guard let nav = storyboard?.instantiateViewController(withIdentifier: "About__Nav") as? UINavigationController else {
            return
        }
        
        present(nav, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didPressPresentAnswer(sender: self)
        return true
    }
}

extension ViewController{
    func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
    }
}
