//
//  WBBCodeCreatViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/8/2.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBCodeCreatViewController: UIViewController {

    @IBOutlet var customQRCodeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let codeImage = UIImage.generateQRImage(QRCodeString: "王宾宾", logo: nil)
        customQRCodeImageView.image = UIImage.createNonInterpolatedUIImageFormCIImage(codeImage!, size: 500)
    }


}
