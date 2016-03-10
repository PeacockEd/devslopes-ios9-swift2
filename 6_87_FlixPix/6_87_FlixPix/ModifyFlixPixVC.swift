//
//  ModifyFlixPixVC.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/9/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ModifyFlixPixVC: ResponsiveTextFieldViewController {
    
    @IBOutlet weak var movieImg:UIImageView!
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var addImgBtn:UIButton!
    
    @IBOutlet weak var titleTextField:UITextField!
    @IBOutlet weak var descTextField:UITextField!
    @IBOutlet weak var urlTextField:UITextField!
    @IBOutlet weak var plotTextField:UITextField!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.bgView.layer.cornerRadius = 6
        self.bgView.clipsToBounds = true
        
        self.addImgBtn.layer.cornerRadius = 10
        self.addImgBtn.clipsToBounds = true
        
        navigationItem.title = "Add a New Flix"
    }

    @IBAction func onCancelTapped(sender:AnyObject)
    {
        navigationController?.popViewControllerAnimated(true)
    }
}
