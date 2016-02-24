//
//  ViewController.swift
//  foto
//
//  Created by Noe De La Mora on 2/13/16.
//  Copyright © 2016 Noe Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filteredImage: UIImage?
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "ImageProcessor.jpg")!
        image = UIImage(named: "ImageProcessor.jpg")!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyFilter(sender: UIButton) {
        if filterButton.selected {
            imageView.image = image
            filterButton.selected = false
        } else {
            moreGreen()
            imageView.image = filteredImage
            filterButton.selected = true
        }
    }
    
    func greyScale() {
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
    
    func moreGreen() {
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
    
}

