//
//  yesnoAPIManager.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

class YesnoAPIManager {
    static let sharedInstance = YesnoAPIManager()
    fileprivate let baseUrl = "https://yesno.wtf/api"
    fileprivate let session = URLSession(configuration: .default)
    
    func fetchAnswerV2(completion: @escaping (Answer?) -> Void){
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) {
            data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let json = try JSON(data: data)
                let answer = Answer(json: json)
                completion(answer)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
