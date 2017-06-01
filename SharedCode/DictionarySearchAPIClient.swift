//
//  DictionarySearchAPIClient.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/10/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DictionarySearchDelegate: class {
    func searchDidComplete(terms: [TermProtocol])
    func searchDidFail(withError error: Error)
}

enum Language {
   case english, japanese
}

class DictionarySearchAPIClient {
    weak var delegate: DictionarySearchDelegate?
    
    func search(forItem item: String, language: Language) {
        let urlString = searchURLString(forLanguage: language)
        let parameters = [
            "term" : item
        ]
        Alamofire.request(urlString, method: .get, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let parser = JDICTParser()
                let json = JSON(value)
                let terms = parser.parse(json: json)
                self.delegate?.searchDidComplete(terms: terms)
            case .failure(let error):
                self.delegate?.searchDidFail(withError: error)
            }
        }
        
    }
    
    fileprivate func searchURLString(forLanguage language: Language) -> String {
        var urlString = ""
        
        switch language {
        case .english:
            urlString = "NOT YET IMPLEMENTED"
        case .japanese:
            urlString = "https://8fe12814.ngrok.io/search?term="
        }
        return urlString
    }
}
