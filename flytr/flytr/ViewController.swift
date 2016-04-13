//
//  ViewController.swift
//  flytr
//
//  Created by Noe De La Mora on 2/13/16.
//  Copyright © 2016 Noe Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var filteredImage: UIImage?
    var image: UIImage?
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var filterSubMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var dog: UIButton!
    @IBOutlet var greenish: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "ImageProcessor.jpg")!
        image = UIImage(named: "ImageProcessor.jpg")!
        
        filterSubMenu.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNewPic(sender: AnyObject) {
        let actionSheet: UIAlertController = UIAlertController(title: "New Picture", message: "pick something!", preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Library", style: .Default, handler: { action in
            self.showLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker: UIImagePickerController = UIImagePickerController()
        
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showLibrary() {
        let photoPicker: UIImagePickerController = UIImagePickerController()
        
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        
        presentViewController(photoPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as?UIImage
        image = imageView.image
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFilter(sender: AnyObject) {
        if filterButton.selected {
            hideFilterSubMenu()
            filterButton.selected = false
        } else {
            showFilterSubMenu()
            filterButton.selected = true
        }
    }

// sub menu button actions to apply filters
    @IBAction func onGreenish(sender: AnyObject) {
        if greenish.selected {
            imageView.image = image
            greenish.selected = false
        } else {
            moreGreen()
            imageView.image = filteredImage
            greenish.selected = true
        }
    }
    
    
    @IBAction func onDog(sender: AnyObject) {
        if dog.selected {
            imageView.image = image
            dog.selected = false
        } else {
            greyScale()
            imageView.image = filteredImage
            dog.selected = true
        }
    }

//private functions
    private func greyScale() {
        let rgbImage = RGBAImage.init(image: image!)!
        
        for y in 0..<rgbImage.height {
            for x in 0..<rgbImage.width {
                let nIndex = y * rgbImage.width + x
                var pixel = rgbImage.pixels[nIndex]
                let maxInt = max(pixel.red, pixel.green, pixel.blue)
                let minInt = min(pixel.red, pixel.green, pixel.blue)
                let light = (Int(maxInt) + Int(minInt)) / 2
                pixel.red = UInt8(light)
                pixel.green = UInt8(light)
                pixel.blue = UInt8(light)
                rgbImage.pixels[nIndex] = pixel
            }
        }
        filteredImage = rgbImage.toUIImage()!
    }
    
    private func moreGreen() {
        let rgbImage = RGBAImage.init(image: image!)!
        
        for y in 0..<rgbImage.height {
            for x in 0..<rgbImage.width {
                let index = y * rgbImage.width + x
                var pixel = rgbImage.pixels[index]
                
                if pixel.red > 120 {
                    pixel.red = UInt8(min(255, max(0, Int(pixel.red) - 20)))
                }
                if pixel.green < 45 {
                    pixel.green = UInt8(max(0, min(255, Int(pixel.green) + 20)))
                }
                rgbImage.pixels[index] = pixel
            }
        }
        filteredImage = rgbImage.toUIImage()!
    }
    
    private func showFilterSubMenu() {
        view.addSubview(filterSubMenu)
        
        let bottomC = filterSubMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftC = filterSubMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightC = filterSubMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightC = filterSubMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomC, leftC, rightC, heightC])
        filterSubMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        view.layoutIfNeeded()
        
        filterSubMenu.alpha = 0
        UIView.animateWithDuration(0.5, animations: {
            self.filterSubMenu.alpha = 1
        })
    }
    
    private func hideFilterSubMenu() {
        UIView.animateWithDuration(0.5, animations: {
            self.filterSubMenu.alpha = 0
            }) { completed in
                if completed {
                    self.filterSubMenu.removeFromSuperview()
            }
        }
    }
}

