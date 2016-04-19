//
//  VideoPlayerViewController.swift
//  CustomVideoPlayer
//
//  Created by Carl Udren on 4/18/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController, VideoControlViewDelegate {

    var avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var controller: VideoControlView?
    var timeObserver: AnyObject!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        controller = VideoControlView(frame: CGRectMake(10, 10, 10, 10), delegate: self)
        view.addSubview(controller!)
        
        
        let timeInterval: CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeObserver = avPlayer.addPeriodicTimeObserverForInterval(timeInterval,
                                                                   queue: dispatch_get_main_queue()) { (elapsedTime: CMTime) -> Void in
                                                                    
                                                                    NSLog("elapsedTime now %f", CMTimeGetSeconds(elapsedTime))
                                                                    self.observeTime(elapsedTime)

        }

        
        // An AVPlayerLayer is a CALayer instance to which the AVPlayer can
        // direct its visual output. Without it, the user will see nothing.
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        
        let url = NSURL(string: "http://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")
        let playerItem = AVPlayerItem(URL: url!)
        avPlayer.replaceCurrentItemWithPlayerItem(playerItem)

    }
    
    deinit {
        avPlayer.removeTimeObserver(timeObserver)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play() // Start the playback
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Layout subviews manually
        avPlayerLayer.frame = view.bounds
        controller!.frame = CGRectMake(0,view.bounds.height-100,view.bounds.width,100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark - TimeObservation
    
    private func updateTimeLabel(elapsedTime: Float64, duration: Float64) {
        let timeRemaining: Float64 = CMTimeGetSeconds(avPlayer.currentItem!.duration) - elapsedTime
        controller!.timeRemainingLabel.text = String(format: "%02d:%02d", ((lround(timeRemaining) / 60) % 60), lround(timeRemaining) % 60)
    }
    
    private func observeTime(elapsedTime: CMTime) {
        let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration);
        if (isfinite(duration)) {
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime, duration: duration)
        }
    }
    
    //Mark - ControlViewDelegate
    
    func playButtonPressed() {
        let playerIsPlaying:Bool = avPlayer.rate > 0
        if (playerIsPlaying) {
            avPlayer.pause();
            controller?.playButton.setTitle("Play", forState: .Normal)

        } else {
            avPlayer.play();
            controller?.playButton.setTitle("Pause", forState: .Normal)


        }

    }
    
    func fullscreenButtonPressed() {
        //
    }
    
    


}

