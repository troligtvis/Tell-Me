//
//  FavoriteManager.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-29.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation
import RealmSwift


class FavoriteManager {
    static let sharedInstance = FavoriteManager()
    
    let realm = try! Realm()
    var favoriteAnswers: Results<FavoriteAnswer>?
    
    func add(answer: FavoriteAnswer){
        do {
            try realm.write {
                realm.add(answer)
            }
        } catch {
            print("failed add")
        }
    }
    
    func removeAnswer(withId id: String){
        guard let favoriteAnswer = realm.object(ofType: FavoriteAnswer.self, forPrimaryKey: id) else { return }
        remove(answer: favoriteAnswer)
    }
    
    func remove(answer: FavoriteAnswer){
        do {
            try realm.write {
                realm.delete(answer)
            }
        } catch {
            print("failed remove")
        }
    }
    
    func fetchFavorite(withId id: String) -> FavoriteAnswer? {
        return realm.objects(FavoriteAnswer.self).filter(NSPredicate(format: "answerId = %@", id)).first
    }
    
    func fetchAll() -> Results<FavoriteAnswer> {
        return realm.objects(FavoriteAnswer.self)
    }
}

