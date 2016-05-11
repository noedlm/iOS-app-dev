//
//  RGBFilter.swift
//  flytr
//
//  Created by Angel De La Mora on 5/3/16.
//  Copyright © 2016 Noe Inc. All rights reserved.
//

import UIKit

public class filterProcessor {
    public var rgbImage: RGBAImage
    
    public init?(image: RGBAImage) {
        self.rgbImage = image
    }
    
    public func greyScale()->RGBAImage {
        for y in 0..<rgbImage.height {
            for x in 0..<rgbImage.width {
                let index = y * rgbImage.width + x
                var pixel = rgbImage.pixels[index]
                let maxInt = max(pixel.red, pixel.green, pixel.blue)
                let minInt = min(pixel.red, pixel.green, pixel.blue)
                let light = (Int(maxInt) + Int(minInt)) / 2
                pixel.red = UInt8(light)
                pixel.green = UInt8(light)
                pixel.blue = UInt8(light)
                rgbImage.pixels[index] = pixel
            }
        }
        
        return rgbImage
    }
    
    public func moreGreen(offset: Int = 10)->RGBAImage {
        for y in 0..<rgbImage.height {
            for x in 0..<rgbImage.width {
                let index = y * rgbImage.width + x
                var pixel = rgbImage.pixels[index]
                
                if pixel.red > 120 {
                    pixel.red = UInt8(max(0, min(255, Int(pixel.red) - offset)))
                }
                if pixel.green < 45 {
                    pixel.green = UInt8(min(255, max(0, Int(pixel.green) + offset)))
                }
                rgbImage.pixels[index] = pixel
            }
        }
        return rgbImage
    }
    
    public func richerDarks(offset: Int = 100, average: Int = 100, difference: Int = 100)->RGBAImage {
        for y in 0..<rgbImage.height {
            for x in 0..<rgbImage.width {
                let index = y * rgbImage.width + x
                var pixel = rgbImage.pixels[index]
                let avg = Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) / 3
                let maxInt = Int(max(pixel.red, pixel.green, pixel.blue))
                let minInt = Int(min(pixel.red, pixel.green, pixel.blue))
                
                if maxInt - minInt <= difference && avg <= average {
                    pixel.red = UInt8(max(0, min(255, Int(pixel.red) - offset)))
                    pixel.green = UInt8(max(0, min(255, Int(pixel.green) - offset)))
                    pixel.blue = UInt8(max(0, min(255, Int(pixel.blue) - offset)))
                }
                rgbImage.pixels[index] = pixel
            }
        }
        return rgbImage
    }
    
    public func lumos(alpha: UInt8 = 225)->RGBAImage {
        for y in 0..<rgbImage.height {
            for x in 0..<rgbImage.width {
                let index = y * rgbImage.width + x
                var pixel = rgbImage.pixels[index]
                pixel.alpha = alpha
                rgbImage.pixels[index] = pixel
            }
        }
        return rgbImage
    }
    
    public func vintagePrinter()->RGBAImage {
        rgbImage = greyScale()
        rgbImage = richerDarks(255, average: 255, difference: 255)
        return rgbImage
    }
    
    public func presetFilters(filter: filterNames)->RGBAImage {
        switch filter {
        case .cartoon:
            rgbImage = moreGreen()
            rgbImage = richerDarks(240, average: 240, difference: 240)
        case .colorBlind:
            rgbImage = greyScale()
        case .goGreen:
            rgbImage = moreGreen()
        case .theVintage:
            rgbImage = vintagePrinter()
        case .iSeeTheLight:
            rgbImage = lumos(180)
            rgbImage = richerDarks(150, average: 150, difference: 150)
            
        }
        return rgbImage
    }
}

public enum filterNames {
    case theVintage
    case goGreen
    case colorBlind
    case cartoon
    case iSeeTheLight
}

