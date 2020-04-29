//
//  ViewController.swift
//  GesturePageControl
//
//  Created by mac23 on 2020/4/29.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var images = [
        UIImage(named: "01.jpg")!,
        UIImage(named: "02.jpg")!,
        UIImage(named: "03.jpg")!,
        UIImage(named: "04.png")!
    ]
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        images.append(UIImage(named: "01.jpg")!)
//        images.append(UIImage(named: "02.jpg")!)
//        images.append(UIImage(named: "03.jpg")!)
//        images.append(UIImage(named: "04.png")!)
        
        imgView.image = images[0]
        pageControl.numberOfPages = images.count
    }
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.left:
            //left swipe
            if pageControl.currentPage < images.count{
                pageControl.currentPage += 1
            }
            break
        case UISwipeGestureRecognizer.Direction.right:
            //right swipe
            if pageControl.currentPage > 0{
                pageControl.currentPage -= 1
            }
            break
        default:
            break
        }
        imgView.image = images[pageControl.currentPage]
    }
    

}

