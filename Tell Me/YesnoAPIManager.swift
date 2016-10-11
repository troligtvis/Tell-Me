//
//  yesnoAPIManager.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class YesnoAPIManager {
    static let sharedInstance = YesnoAPIManager()
    fileprivate let baseUrl = "https://yesno.wtf/api"
    
    func fetchAnswer(completionHandler: @escaping (Answer?) -> Void){
        guard let url = URL(string: baseUrl) else {
            // TODO: - Return default image/gif
            completionHandler(nil)
            return
        }
        
        Alamofire.request(url).responseJSON{
            response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                let answer = Answer(json: json)
                completionHandler(answer)
            case .failure(let error):
                // TODO: - Return not found image/gif
                print(error.localizedDescription)
                completionHandler(nil)
                break
            }
        }
    }
}
