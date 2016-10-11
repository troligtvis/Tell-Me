//
//  PopupViewController.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit
import Kingfisher


class PopupViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var imagePlaceholderView: UIView!
    
    var answer: Answer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPopupView()
        populateCard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PopupViewController{
    func setupPopupView(){
        popupView.layer.cornerRadius = 10
        //popupView.layer.borderColor = UIColor.black.cgColor
        //popupView.layer.borderWidth = 0.25
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.6
        popupView.layer.shadowRadius = 15
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.masksToBounds = false
    }
    
    func populateCard(){
        let urlString = answer.url ?? ""
        let url = URL(string: urlString)
        
        answerLabel.text = answer.value ?? ""
        
        answerImageView.kf_indicatorType = .activity
        answerImageView.kf_setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { _ in
            UIView.animate(withDuration: 0.2, animations: { _ in
                self.answerLabel.alpha = 1.0
            })
        })
    }
}

extension PopupViewController{
    @IBAction func shareGif(){
        guard let url = answer.url, let value = answer.value else { return }
        let activity = UIActivityViewController(activityItems: ["The answer is \(value)!", url], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
}
