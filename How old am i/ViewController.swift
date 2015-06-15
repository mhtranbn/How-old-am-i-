//
//  ViewController.swift
//  How old am i
//
//  Created by mhtran on 5/5/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    

    @IBAction func cameraTake(sender: AnyObject) {
        
        var CameraTakeVC = CameraVC()
        self.navigationController?.pushViewController(CameraTakeVC, animated: true)
        NSLog("sang camera")
    }
    @IBAction func garallyGet(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    //let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as SecondViewController
    
    //self.navigationController.pushViewController(secondViewController, animated: true)


}

