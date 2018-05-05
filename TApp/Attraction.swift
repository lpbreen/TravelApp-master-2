//
//  Attraction.swift
//  TApp
//
//  Created by Liam Breen on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import Foundation
import SwiftyJSON

class Attraction: NSObject {
    var name: String
    var img: NSData?
    var url: URL?
    
    init(name: String, url: URL?) {
        self.name = name
        self.url = url
        
        if let unwrappedUrl = self.url {
            do {
                let data: NSData = try NSData(contentsOf: unwrappedUrl)
                self.img = data
            } catch {
                self.img = nil
                print("Error /(error)")
            }
        }
    }
    
//    init(from business: CDYelpBusiness) {
//        self.name = business.name
//        self.ingredients = json["ingredients"].stringValue
//        self.url = URL(string: json["href"].stringValue)!
//
//        if let url: URL = URL(string: json["thumbnail"].stringValue) {
//            do {
//                let data: NSData = try NSData(contentsOf: url)
//                self.img = data
//            } catch {
//                print("Error /(error)")
//            }
//        }
//    }
    
}
