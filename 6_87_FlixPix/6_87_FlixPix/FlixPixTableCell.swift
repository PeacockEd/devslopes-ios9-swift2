//
//  FlixPixTableCell.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/9/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class FlixPixTableCell: UITableViewCell {
    
    @IBOutlet weak var cellImgView:UIImageView!
    @IBOutlet weak var linkBtn:UIButton!
    @IBOutlet weak var titleBgView:UIView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.cellImgView.clipsToBounds = true
        
        self.titleBgView.layer.cornerRadius = 6
        self.titleBgView.clipsToBounds = true
    }
    
    func configureCell(item:FlixPixItem)
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 180/255.0, green: 138/255.0, blue: 171/255.0, alpha: 0.5)
        self.selectedBackgroundView = view
        
        cellImgView.image = item.getFlixImg()
        descriptionLabel.text = item.itemDesc
        titleLabel.text = item.title
        
    }
    
    @IBAction func onLinkBtnTapped(sender:AnyObject)
    {
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
