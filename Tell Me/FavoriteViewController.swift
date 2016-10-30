//
//  FavoriteViewController.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-29.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    fileprivate var dataSource: UITableViewDataSource?
    fileprivate var selectedAnswer: Answer?
    fileprivate var selectedFav: FavoriteAnswer?
    let dimLevel: CGFloat = 0.5
    let dimSpeed: Double = 0.5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = FavoriteTableViewDataSource()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavoriteViewController: Dimmable{
    @IBAction func unwindFromPopupView(segue: UIStoryboardSegue){
        dim(direction: .down, speed: dimSpeed)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        favoriteTableView.reloadData()
    }
    
    func presentAnswer(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Popup__View") as? PopupViewController else { return }
        //vc.answer = selectedAnswer
        vc.favoriteAnswer = selectedFav
        dim(direction: .up, alpha: dimLevel, speed: dimSpeed)
        present(vc, animated: true, completion: nil)
    }
}

extension FavoriteViewController {
    @IBAction func didPressBack(sender: AnyObject){
        self.dismiss(animated: true, completion: nil)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = dataSource as? FavoriteTableViewDataSource else {
            print("no data source :/")
            return
        }
        
        let fav = data.favoriteAnswers[indexPath.row]
        selectedFav = fav
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        presentAnswer()
    }
}
