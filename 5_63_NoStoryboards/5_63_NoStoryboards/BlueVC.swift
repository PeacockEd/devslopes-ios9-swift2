//
//  BlueVC.swift
//  5_63_NoStoryboards
//
//  Created by Edward P. Kelly on 3/3/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class BlueVC: UIViewController {
    
    var redVC:RedVC!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loadRedView(sender: UIButton)
    {
        redVC = RedVC(nibName: "RedVC", bundle: nil)
        presentViewController(redVC, animated: true, completion: nil)
    }
    
    
    @IBAction func onBackTapped(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
