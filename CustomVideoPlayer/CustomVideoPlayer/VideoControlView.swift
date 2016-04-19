//
//  VideoControlView.swift
//  CustomVideoPlayer
//
//  Created by Carl Udren on 4/18/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol VideoControlViewDelegate {
    func playButtonPressed()
    func fullscreenButtonPressed()
}


class VideoControlView: UIView {
    
    let playButton = UIButton()
    var timeRemainingLabel: UILabel = UILabel()
    var delegate: VideoControlViewDelegate!
    
 
    convenience init(frame: CGRect, delegate: VideoControlViewDelegate){
        self.init(frame: frame)
        
        //delegate
        self.delegate = delegate
        
        //setup play button
        playButton.backgroundColor = UIColor.clearColor()
        playButton.titleLabel?.textColor = UIColor.whiteColor()
        playButton.setTitle("Pause", forState: .Normal)
        playButton.addTarget(self, action: #selector(handlePlayButton), forControlEvents: .TouchUpInside)
        addSubview(playButton)
        
        
        //config time remaining button
        timeRemainingLabel.textColor = UIColor.whiteColor()
        addSubview(timeRemainingLabel)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        playButton.frame = CGRectMake(0, 0, frame.width/3, frame.height)
        timeRemainingLabel.frame = CGRectMake(frame.width/3, 0, frame.width/3, frame.height)
    }
    
    func handlePlayButton(sender: UIButton){
        delegate.playButtonPressed()
    }
}
