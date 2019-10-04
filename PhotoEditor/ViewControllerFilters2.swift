//
//  ViewControllerFilters2.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/23/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit

class ViewControllerFilters2: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var filteredImage: UIImage?
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = filteredImage!
    }
}
