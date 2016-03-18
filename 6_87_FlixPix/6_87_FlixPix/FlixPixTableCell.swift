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
    
    private var imdbUrl:String?
    

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
        view.backgroundColor = UIColor(red: 40/255.0, green: 122/255.0, blue: 66/255.0, alpha: 0.5)
        self.selectedBackgroundView = view
        
        cellImgView.image = item.getFlixImg()
        descriptionLabel.text = item.itemDesc
        titleLabel.text = item.title
        
        formLinkUrl(item.imdbLink)
    }
    
    private func formLinkUrl(url:String?)
    {
        if let linkUrl = url {
            imdbUrl = linkUrl
            let rangeOfHttp = linkUrl.rangeOfString("http://")
            if rangeOfHttp == nil {
                imdbUrl = "http://" + linkUrl
            }
        }
    }
    
    @IBAction func onLinkBtnTapped(sender:AnyObject)
    {
        if let link_url = imdbUrl, let url = NSURL(string: link_url) {
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
