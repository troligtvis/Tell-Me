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
    @IBOutlet weak var popupView: UIView! {
        didSet{
            popupView.layer.cornerRadius = 10
            popupView.layer.borderColor = UIColor.black.cgColor
            popupView.layer.borderWidth = 0.25
            popupView.layer.shadowColor = UIColor.black.cgColor
            popupView.layer.shadowOpacity = 0.6
            popupView.layer.shadowRadius = 15
            popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
            popupView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var imagePlaceholderView: UIView!
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var favoriteImageVIew: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    

    fileprivate var answer: Answer?
    fileprivate var url: URL?
    var favoriteAnswer: FavoriteAnswer?
    var question: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let fav = favoriteAnswer else {
            questionLabel.text = "\(question!)?"
            requestAnswer()
            return
        }
        
        guard let answer = Answer(fav: fav) else { return }
        self.answer = answer

        favoriteImageVIew.image = UIImage(named: "star_icon_filled")
        answer.isFavorite = true

        question = answer.question
        questionLabel.text = "\(question!)?"
        populateCard(withAnswer: answer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateButtons()
    }
}

extension PopupViewController{
    func setupButtons(){
        favoriteView.layer.cornerRadius = favoriteView.frame.width / 2
        shareView.layer.cornerRadius = shareView.frame.width / 2
        closeView.layer.cornerRadius = closeView.frame.width / 2
        
        favoriteView.alpha = 0.0
        shareView.alpha = 0.0
        closeView.alpha = 0.0
    }
    
    func animateButtons(){
        closeView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        favoriteView.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
        shareView.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
        
        animateShowButton(closeView, withDelay: 0.0)
        self.animateShowButton(self.favoriteView, withDelay: 0.2)
        self.animateShowButton(self.shareView, withDelay: 0.3)
    }
    
    
    func animateShowButton(_ v: UIView, withDelay delay: Double){
        UIView.animate(withDuration: 0.2, delay: delay, animations: {
            v.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
            v.alpha = 1.0
            
        }, completion: { finish in
            UIView.animate(withDuration: 0.3, animations: {
                v.transform = CGAffineTransform.identity.scaledBy(x: 0.05, y: 0.05)

            }, completion: { finish in
                UIView.animate(withDuration: 0.2, animations: {
                    v.transform = CGAffineTransform.identity
                    
                }, completion: { finish in
                    // self.wiggleButtons()
                })
            })
        })
    }
    
    func animateWiggleButton(_ v: UIView){
        UIView.animate(withDuration: 0.1, animations: {
            v.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/12))
            
        }, completion: { finish in
            UIView.animate(withDuration: 0.1, animations: {
                v.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/12))
                
            }, completion: { finish in
                UIView.animate(withDuration: 0.1, animations: {
                    v.transform = CGAffineTransform.identity
                    
                })
            })
        })
    }
    
    func wiggleButtons(){
        UIView.animate(withDuration: 0.2, animations: {
            self.closeView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/12))
            self.favoriteView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/12))
            self.shareView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/12))
            
        }, completion: { finish in
            UIView.animate(withDuration: 0.2, animations: {
                self.closeView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/12))
                self.favoriteView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/12))
                self.shareView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/12))
                
            }, completion: { finish in
                UIView.animate(withDuration: 0.2, animations: {
                    self.closeView.transform = CGAffineTransform.identity
                    self.favoriteView.transform = CGAffineTransform.identity
                    self.shareView.transform = CGAffineTransform.identity
                })
            })
        })
    }
    
    func populateCard(withAnswer answer: Answer){
        let urlString = answer.url ?? ""
        url = URL(string: urlString)
        let downloader = ImageCacheManager.sharedInstance.downloader
        let cache = ImageCacheManager.sharedInstance.cache
        
        answerLabel.text = answer.value ?? ""
        answerImageView.kf_indicatorType = .activity
        answerImageView.kf_setImage(with: url, placeholder: nil, options: [.downloader(downloader), .targetCache(cache)], progressBlock: nil){ _ in
            self.answerLabel.alpha = 1.0
        }
        
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
        
        YesnoAPIManager.sharedInstance.fetchAnswerV2{
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
        
        DispatchQueue.main.async {
            self.populateCard(withAnswer: answer)
        }
    }
}

extension PopupViewController{
    @IBAction func didPressFavorite(sender: AnyObject){
        guard let answer = answer else {
            print("No answer!")
            return
        }
        answer.isFavorite = !answer.isFavorite
    
        favoriteImageVIew.image = UIImage(named: answer.isFavorite ? "star_icon_filled" : "star_icon_unfilled")
        
        if answer.isFavorite {
            let fav = FavoriteAnswer()
            fav.cacheKey = ""
            fav.question = question
            fav.value = answer.value ?? ""
            fav.imageUrl = answer.url ?? ""
            
            FavoriteManager.sharedInstance.add(answer: fav)
            
            favoriteAnswer = fav
            animateWiggleButton(favoriteView)
        } else {
            guard let id = favoriteAnswer?.answerId else {
                print("No favorite answer saved :/")
                return
            }
            
            FavoriteManager.sharedInstance.removeAnswer(withId: id)
        }
    }
    
    @IBAction func shareGif(){
        guard let url = answer?.url, let a = answer?.value, let q = self.question else { return }
        let text = "\(q)? The answer is \(a)!"
        let activity = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
}
