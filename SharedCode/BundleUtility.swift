//
//  BundleUtility.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

public class BundleUtility {
    
    public init() {}
    
    public func sharedCodeBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
}
