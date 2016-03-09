//
//  FlixPixTableCell.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/9/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class FlixPixTableCell: UITableViewCell {
    
    @IBOutlet weak var cellImg:UIImageView!
    @IBOutlet weak var linkBtn:UIButton!
    @IBOutlet weak var titleBgView:UIView!
    @IBOutlet weak var titleLabel:UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.titleBgView.layer.cornerRadius = 6
        self.titleBgView.clipsToBounds = true
    }
    
    @IBAction func onLinkBtnTapped(sender:AnyObject)
    {
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
