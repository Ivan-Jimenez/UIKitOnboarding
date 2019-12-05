//
//  ViewController.swift
//  UIKitOnboarding
//
//  Created by Alexis Jimenez on 05/12/19.
//  Copyright © 2019 Alexis Jimenez. All rights reserved.
//

import UIKit

struct ScrollDataStruct {
    let imageFront: UIImage?
    let imageBack: UIImage?
}

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollViewData = [ScrollDataStruct]()
    
    var viewTagValue = 10
    var tagValue = 100
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        scrollViewData = [ScrollDataStruct.init(imageFront: #imageLiteral(resourceName: "person1") imageBack: #imageLiteral(resourceName: "element1")),
                          ScrollDataStruct.init(imageFront: #imageLiteral(resourceName: "person2"), imageBack: #imageLiteral(resourceName: "element2")),
                          ScrollDataStruct.init(imageFront: #imageLiteral(resourceName: "person3"), imageBack: #imageLiteral(resourceName: "element3"))]
        
        scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(scrollViewData.count)
        scrollView.showsHorizontalScrollIndicator = false
        
        var i = 0
        for data in scrollViewData {
            let view = CustomView(frame: CGRect(x: 10 + (self.scrollView.frame.width   * CGFloat(i)), y: 80,  width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height))
            
            view.imageView.image = data.imageFront
            view.tag = i + viewTagValue
            self.scrollView.addSubview(view)
            
            let label = UILabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 20), size: CGSize.init(width: 0, height: 40)))
            label.text = data.title
            label.font = UIFont.boldSystemFont(ofSize:  30)
            label.textColor = UIColor.black
            label.sizeToFit()
            label.tag = i + tagValue
            if i == 0 {
                label.center.x = view.center.x
            } else {
                label.center.x = view.center.x -  self.scrollView.frame.width / 2
            }
            
            self.scrollView.addSubview(label)
             
            i += 1
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            for  i in 0..<scrollViewData.count {
                let label = scrollView.viewWithTag(i + tagValue) as! UILabel
                let view = scrollView.viewWithTag(i + viewTagValue) as! CustomView
                
                let scrollContentOffset = scrollView.contentOffset.x + self.scrollView.frame.width
                let viewOffset = (view.center.x - scrollView.bounds.width / 4) - scrollContentOffset
                label.center.x = scrollContentOffset - ((scrollView.bounds.width / 4 - viewOffset) / 2)
            }
        }
    }

}


class CustomView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
