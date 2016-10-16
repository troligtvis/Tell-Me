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
    
    let dimLevel: CGFloat = 0.5
    let dimSpeed: Double = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareIntroLabel()
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
        self.presentAnswer()
    }
}
