//
//  extensionRepalceString.swift
//  How old am i
//
//  Created by mhtran on 5/6/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}