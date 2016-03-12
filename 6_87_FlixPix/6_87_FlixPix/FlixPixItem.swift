//
//  FlixPixItem.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/11/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FlixPixItem: NSManagedObject {

    func setFlixImg(img:UIImage)
    {
        let data = UIImagePNGRepresentation(img)
        self.imageData = data
    }
    
    func getFlixImg() -> UIImage
    {
        let img = UIImage(data: self.imageData!)!
        return img
    }
}
