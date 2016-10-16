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
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var question: String!
    fileprivate var answer: Answer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPopupView()
        requestAnswer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PopupViewController{
    func setupPopupView(){
        popupView.layer.cornerRadius = 10
        popupView.layer.borderColor = UIColor.black.cgColor
        popupView.layer.borderWidth = 0.25
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.6
        popupView.layer.shadowRadius = 15
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.masksToBounds = false
    }
    
    func populateCard(withAnswer answer: Answer){
        let urlString = answer.url ?? ""
        let url = URL(string: urlString)
        
        answerLabel.text = answer.value ?? ""
        
        answerImageView.kf_indicatorType = .activity
        answerImageView.kf_setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { _ in
            UIView.animate(withDuration: 0.2, animations: { _ in
                self.answerLabel.alpha = 1.0
            })
        })
        
        shareButton.isEnabled = true
    }
    
    fileprivate func createCard(imageName name: String, withText text: String = ""){
        answerLabel.text = text
        answerLabel.alpha = 1.0
        answerImageView.loadGif(name: name)
        answerImageView.alpha = 1.0
    }
    
    func populateCard(withCardType type: CardType){
        switch type {
        case .waiting: createCard(imageName: "waiting_1", withText: "Waiting..")
        case .notFound: createCard(imageName: "not_found_2")
        }
    }
}

extension PopupViewController {
    func requestAnswer(){
        populateCard(withCardType: .waiting)
        
        YesnoAPIManager.sharedInstance.fetchAnswer{
            answer in
            
            guard let answer = answer else {
                self.populateCard(withCardType: .notFound)
                return
            }
            
            self.presentAnswer(answer)
        }
    }
    
    func presentAnswer(_ answer: Answer){
        self.answer = answer
        populateCard(withAnswer: answer)
    }
}

extension PopupViewController{
    @IBAction func shareGif(){
        guard let url = answer?.url, let a = answer?.value, let q = self.question else { return }
        let text = "\(q)? The answer is \(a)!"
        let activity = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
}
