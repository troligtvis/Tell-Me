//
//  FavoriteTableViewDataSource.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-29.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit


class FavoriteTableViewDataSource: NSObject, UITableViewDataSource {
    
    let favoriteAnswers = FavoriteManager.sharedInstance.fetchAll()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let answer = favoriteAnswers[indexPath.row]
        cell.textLabel?.text = answer.question
        cell.detailTextLabel?.text = answer.value
        return cell
    }
    
    
}
