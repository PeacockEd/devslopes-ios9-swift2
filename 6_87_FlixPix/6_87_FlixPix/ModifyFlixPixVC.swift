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
    private var _flixPixItem:FlixPixItem?
    private var selectedImage:UIImage?
    
    
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
        
        self.bgView.layer.cornerRadius = 6
        self.bgView.clipsToBounds = true
        
        self.addImgBtn.layer.cornerRadius = 10
        self.addImgBtn.clipsToBounds = true
        
        self.deleteBtn.layer.cornerRadius = 10
        self.deleteBtn.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        selectedImage = image
        addImgBtn.setTitle("Update Photo", forState: .Normal)
        cameraIcon.alpha = 0.0
    }
    
    private func configureView()
    {
        if let item = flixPixItem {
            navigationItem.title = "Edit Item"
            if let image = selectedImage {
                movieImg.image = image
            } else {
                movieImg.image = item.getFlixImg()
            }
            titleTextField.text = item.title
            descTextField.text = item.itemDesc
            plotTextField.text = item.itemPlot
            urlTextField.text = item.imdbLink
            cameraIcon.alpha = 0.0
            addImgBtn.setTitle("Update Photo", forState: .Normal)
            deleteBtn.hidden = false
        } else {
            navigationItem.title = "Add a New Flix"
            deleteBtn.hidden = true
            if let image = selectedImage {
                movieImg.image = image
            }
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
        if let item = flixPixItem, let context = item.managedObjectContext {
            context.deleteObject(item)
            do {
                try context.save()
            } catch {
                print("Unable to delete item!")
            }
        }
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func onDoneTapped(sender:AnyObject)
    {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if let currentItem = flixPixItem {
            // EDIT existing item
            currentItem.title = titleTextField.text
            currentItem.itemDesc = descTextField.text
            currentItem.imdbLink = urlTextField.text
            currentItem.itemPlot = plotTextField.text
            if let image = movieImg.image {
                currentItem.setFlixImg(image)
            }
        } else {
            // NEW item
            if let title = titleTextField.text where title != "" {
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
                }
            }
        }
        do {
            try context.save()
        } catch {
            print("Unable to save item!")
        }
        popToTableView()
    }

    @IBAction func onCancelTapped(sender:AnyObject)
    {
        popToTableView()
    }
}
