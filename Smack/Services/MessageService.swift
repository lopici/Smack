//
//  MessageService.swift
//  Smack
//
//  Created by Andras on 2/11/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService() //singleton
    var channels = [Channel]()
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["id"].stringValue
                        
                        let channel = Channel(channelTitle: name, channelTDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    completion(true)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
                
            }
        }
    }
 }
