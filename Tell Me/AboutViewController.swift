//
//  AboutViewController.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-30.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let formattedString = NSMutableAttributedString().normal(text: "\"").bold(text: "Ask Me This", size: 17, weight: UIFontWeightBold).normal(text: "\"").normal(text: " app is using the API from")
        //formattedString.link(find: "yesno.wtf", url: "https://yesno.wtf")
        aboutLabel.attributedText = formattedString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AboutViewController {
    @IBAction func didPressBack(sender: AnyObject){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressLink(){
        openUrl("https://yesno.wtf")
    }
    
    @IBAction func didPressName(sender: AnyObject){
        guard let tag = sender.tag else { return }
        switch tag {
        case 0: openUrl("https://twitter.com/neuling2k")
        case 1: openUrl("https://twitter.com/crtvhd")
        case 2: openUrl("https://twitter.com/em0ne")
        default: return
        }
    }
    
    func openUrl(_ u: String) {
        guard let url = URL(string: u) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
