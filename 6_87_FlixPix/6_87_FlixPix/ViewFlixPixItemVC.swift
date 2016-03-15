//
//  ViewFlixPixItemVC.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/9/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewFlixPixItemVC: UIViewController {
    
    @IBOutlet weak var movieImg:UIImageView!
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var imdbButton:UIButton!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descLabel:UILabel!
    @IBOutlet weak var plotLabel:UILabel!
    @IBOutlet weak var linkLabel:UILabel!
    
    private var _flixPixItem:FlixPixItem?
    
    var flixPixItem:FlixPixItem? {
        get {
            return _flixPixItem
        }
        set {
            _flixPixItem = newValue
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if let item = flixPixItem { configureView(item) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bgView.layer.cornerRadius = 6
        self.bgView.clipsToBounds = true
        
        self.movieImg.clipsToBounds = true
    }
    
    func configureView(item:FlixPixItem)
    {
        movieImg.image = item.getFlixImg()
        titleLabel.text = item.title
        descLabel.text = item.itemDesc
        plotLabel.text = item.itemPlot
        linkLabel.text = item.imdbLink
    }
}
