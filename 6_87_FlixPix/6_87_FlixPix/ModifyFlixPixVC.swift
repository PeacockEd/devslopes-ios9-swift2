//
//  ModifyFlixPixVC.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/9/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit
import CoreData

class ModifyFlixPixVC: ResponsiveTextFieldViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    @IBOutlet weak var movieImg:UIImageView!
    @IBOutlet weak var cameraIcon:UIImageView!
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var addImgBtn:UIButton!
    @IBOutlet weak var deleteBtn:UIButton!
    
    @IBOutlet weak var titleTextField:UITextField!
    @IBOutlet weak var descTextField:UITextField!
    @IBOutlet weak var urlTextField:UITextField!
    @IBOutlet weak var plotTextField:UITextField!
    
    private var imagePicker:UIImagePickerController!
    private var isActiveItem = false
    private var _flixPixItem:FlixPixItem?
    
    var flixPixItem:FlixPixItem? {
        get {
            return _flixPixItem
        }
        set {
            _flixPixItem = newValue
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        deleteBtn.hidden = !isActiveItem
        
        self.bgView.layer.cornerRadius = 6
        self.bgView.clipsToBounds = true
        
        self.addImgBtn.layer.cornerRadius = 10
        self.addImgBtn.clipsToBounds = true
        
        self.deleteBtn.layer.cornerRadius = 10
        self.deleteBtn.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        configureView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //configureView()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        movieImg.image = image
        
        addImgBtn.titleLabel?.text = "Edit Photo"
        cameraIcon.alpha = 0.0
    }
    
    private func configureView()
    {
        if let item = flixPixItem {
            navigationItem.title = "Edit Item"
            self.titleTextField.text = item.title
        } else {
            navigationItem.title = "Add a New Flix"
        }
    }
    
    private func popToTableView()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onAddPhotoTapped(sender:AnyObject)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onDeleteItemTapped(sender:AnyObject)
    {
        
    }
    
    @IBAction func onDoneTapped(sender:AnyObject)
    {
        if let title = titleTextField.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            if let entity = NSEntityDescription.entityForName("FlixPixItem", inManagedObjectContext: context) {
                let item = FlixPixItem(entity: entity, insertIntoManagedObjectContext:context)
                item.title = titleTextField.text
                item.itemDesc = descTextField.text
                item.imdbLink = urlTextField.text
                item.itemPlot = plotTextField.text
                if let image = movieImg.image {
                    item.setFlixImg(image)
                }
                context.insertObject(item)
                do {
                    try context.save()
                } catch {
                    print("Unable to save item!")
                }
            }
        }
        popToTableView()
    }

    @IBAction func onCancelTapped(sender:AnyObject)
    {
        popToTableView()
    }
}
