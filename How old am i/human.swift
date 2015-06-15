//
//  human.swift
//  How old am i
//
//  Created by mhtran on 5/7/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation

public class human {
    public  var age:Float
    public var gender: String
    public var top:Float
    public var left:Float
    public var width:Float
    public var height:Float
    init (age: Float = 0, gender: String = "", top: Float = 0, left: Float = 0, width:Float = 0, height: Float = 0) {
        self.age = age as Float
        self.top = top as Float
        self.left = left as Float
        self.width = width as Float
        self.height = height as Float
        self.gender = gender as String
    }
    
//     init(){
//        self.age = 0
//        self.top = 0
//        self.left = 0
//        self.width = 0
//        self.height = 0
//        self.gender = ""
//    }
    
    
    
}