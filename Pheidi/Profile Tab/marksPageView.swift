//
//  marksPageView.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/15/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class marksPageView: UIView, UIScrollViewDelegate {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var divisionPrediction: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var divisionLabel: UILabel!
    
    let screen = UIScreen.main.bounds
    
    func setup(_ dict: [String: String]) {
        divisionLabel.text = user.division
        pageControl.numberOfPages = dict.count
        pageControl.currentPage = 0
        self.bringSubviewToFront(pageControl)
        scrollView.delegate = self
        var slides: [UIView] = []
        for (event, mark) in dict {
            let page = Bundle.main.loadNibNamed("marksCell", owner: self, options: nil)?.first as? marksCell
            page!.event.text = event
            page!.mark.text = mark
            slides.append(page!)
        }
        setupSlides(slides)
    }
    
    func setupSlides(_ slides: [UIView]) {
        let width = screen.width
        scrollView.frame = CGRect(x: 0, y: 0, width:width, height: 124)
        scrollView.contentSize = CGSize(width: width * CGFloat(slides.count), height: 124)
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: 124)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = screen.width
        let page = round(scrollView.contentOffset.x / width)
        pageControl.currentPage = Int(page)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
