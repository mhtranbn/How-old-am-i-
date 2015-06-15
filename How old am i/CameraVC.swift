//
//  CameraVC.swift
//  How old am i
//
//  Created by mhtran on 5/5/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import UIKit
import Foundation
//import CoreData
import MobileCoreServices
import CoreGraphics
import QuartzCore

class CameraVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {


    @IBOutlet weak var cameraView: UIImageView!
    var camera2: UIImageView!

    @IBAction func takeCamera(sender: AnyObject) {
        takePhoto()
    }
    @IBAction func getGarally(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
    var picker                          = UIImagePickerController()
    picker.delegate                     = self
    picker.sourceType                   = UIImagePickerControllerSourceType.PhotoLibrary
    picker.allowsEditing                = true
            self.presentViewController(picker, animated: true, completion: nil)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        takePhoto()




    }

    override func viewWillAppear(animated: Bool) {

    }

    func takePhoto() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
    var picker                          = UIImagePickerController()
    picker.delegate                     = self
    picker.sourceType                   = UIImagePickerControllerSourceType.Camera
    var mediaTypes:Array<AnyObject>     = [kUTTypeImage]
    picker.mediaTypes                   = mediaTypes
    picker.allowsEditing                = true
            self.presentViewController(picker, animated: true, completion: nil)
        } else {
            NSLog("No came ra")
        }
    }


    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        NSLog("Did Finish Picking")
    let borderWidth: CGFloat           = 2.0
    let mediaType                      = info[UIImagePickerControllerMediaType] as! String
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
    let compResult: CFComparisonResult = CFStringCompare(mediaType as NSString!, kUTTypeImage, CFStringCompareFlags.CompareCaseInsensitive)
        if ( compResult == CFComparisonResult.CompareEqualTo) {
    editedImage                        = info[UIImagePickerControllerEditedImage] as! UIImage?
    originalImage                      = info[UIImagePickerControllerOriginalImage] as! UIImage?
            if ( editedImage == nil) {
    imageToSave                        = editedImage
            } else {
    imageToSave                        = originalImage
            }
            NSLog("Write To saved photos")

    let imagePicked                    = info[UIImagePickerControllerOriginalImage] as! UIImage
            UIGraphicsBeginImageContextWithOptions(cameraView.frame.size, false, 0)


    cameraView.image                   = RBSquareImageTo(imageToSave!, size: CGSize(width: 320, height: 480))


            self.requestToServer(cameraView.image!)
    let hcn                            = UIBezierPath(rect: CGRect(x: Double(nguoi1.left), y: Double(nguoi1.top), width: Double(nguoi1.width), height: Double(nguoi1.height )))
            imagePicked.drawInRect(cameraView.bounds)
            UIColor.purpleColor().setStroke()
    hcn.lineWidth                      = borderWidth
            hcn.stroke()
    var roundedImage                   = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext()
    cameraView?.image                     = roundedImage
            cameraView?.reloadInputViews()
            UIImageWriteToSavedPhotosAlbum(cameraView?.image, nil, nil, nil)

        }
        picker.dismissViewControllerAnimated(true, completion: nil)

    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in

        })
        cameraView.image                   = RBSquareImageTo(image, size: CGSize(width: 320, height: 480))
        self.requestToServer(cameraView.image!)
    }


    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{

        // Setup the font specific variables
    var textColor: UIColor              = UIColor.whiteColor()
    var textFont: UIFont                = UIFont(name: "Helvetica Bold", size: 12)!

        //Setup the image context using the passed image.
        UIGraphicsBeginImageContext(inImage.size)

        //Setups up the font attributes that will be later used to dictate how the text should be drawn
    let textFontAttributes              = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]

        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))

        // Creating a point within the space that is as bit as the image.
    var rect: CGRect                    = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)

        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)

        // Create a new image out of the images we have created
    var newImage: UIImage               = UIGraphicsGetImageFromCurrentImageContext()

        // End the context now that we have the image we need
        UIGraphicsEndImageContext()

        //And pass it back up to the caller.
        return newImage

    }

    func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage {
        return RBResizeImage(RBSquareImage(image), targetSize: size)
    }

    func RBSquareImage(image: UIImage) -> UIImage {
    var originalWidth                   = image.size.width
    var originalHeight                  = image.size.height

        var edge: CGFloat
        if originalWidth > originalHeight {
    edge                                = originalHeight
        } else {
    edge                                = originalWidth
        }

    var posX                            = (originalWidth  - edge) / 2.0
    var posY                            = (originalHeight - edge) / 2.0

    var cropSquare                      = CGRectMake(posX, posY, edge, edge)

    var imageRef                        = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)!
    }

    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size                            = image.size

    let widthRatio                      = targetSize.width  / image.size.width
    let heightRatio                     = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
    newSize                             = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
    newSize                             = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
    let rect                            = CGRectMake(0, 0, newSize.width, newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
    let newImage                        = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    var nguoi1: human                   = human()

    func requestToServer(imagenReduced:UIImage) -> human {

    let url                             = NSURL(string:"http://how-old.net/Home/Analyze?isTest=False")
    let cachePolicy                     = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    var imageData :NSData               = UIImageJPEGRepresentation(imagenReduced, 1.0);
    var request                         = NSMutableURLRequest()
    request.URL                         = url
    request.HTTPMethod                  = "POST"
    var timeoutInterval: NSTimeInterval = 1000
    request.timeoutInterval             = timeoutInterval
        request.setValue("application/octet-stream", forHTTPHeaderField:"Content-Type")
    var body                            = NSMutableData();
        body.appendData(imageData)
    request.HTTPBody                    = body
    var response: NSURLResponse?        = nil
    var error: NSError?                 = nil
    let reply                           = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        if (reply == nil) {
            NSLog("Khong xac dinh duoc khuon mat")
        }
    var results                         = NSString(data:reply!, encoding:NSUTF8StringEncoding)
    let resultsString:String            = results as String!
    let jsonn                           = resultsString.replace("\\\\r\\\\n", withString:"")
    let json1                           = jsonn.replace("\\\\\\", withString:"")
    let json2                           = json1.replace("\"{", withString:"{")
    let json3                           = json2.replace("}\"", withString:"}")
    let json4                           = json3.replace("\\", withString:"")
    let json5                           = json4.replace("}\"", withString:"}")
    let json6                           = json5.replace("\"[", withString:"[")
    let json7                           = json6.replace("]\"", withString:"]")
    let json8                           = json7.replace("}]\",", withString:"}],")
    var data                            = json8.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        var localError: NSError?
    var json: AnyObject!                = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &localError)
    if let dict                         = json as? [String: AnyObject] {
    if let AnalyticsEvent               = dict["AnalyticsEvent"] as? [AnyObject] {
                for dict2 in AnalyticsEvent {
    let face                            = dict2["face"]

                }
            }

    if let Faces                        = dict["Faces"] as? [AnyObject] {
                for dict3 in Faces {
                    if (dict3 as? NSDictionary != nil) {
    if let rect                         = dict3["faceRectangle"] as? NSDictionary {
                            print(rect["top"])
                            print(rect["left"])
                            print(rect["width"])
                            print(rect["height"])
    self.nguoi1.top                     = rect["top"] as! Float
    self.nguoi1.left                    = rect["left"] as! Float
    self.nguoi1.width                   = rect["width"] as! Float
    self.nguoi1.height                  = rect["height"] as! Float

                        }

    if let butes                        = dict3["attributes"] as? NSDictionary {
    self.nguoi1.gender                  = butes["gender"] as! String
    self.nguoi1.age                     = butes["age"] as! Float
                        }

                    }

                }
            }
        }
        return nguoi1
    }


}

