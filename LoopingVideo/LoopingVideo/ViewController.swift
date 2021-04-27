//
//  ViewController.swift
//  LoopingVideo
//
//  Created by hyunji on 2020/12/19.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    let url = NSURL(string: "https://wherewhere-bucket.s3.ap-northeast-2.amazonaws.com/videos/original/hp4Pu4nmR2UzWTJP01.mp4")
    var player: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVPlayer(url: url! as URL)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.player.currentItem) // Add observer
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }

    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.player.seek(to: CMTime.zero)
       self.player.play()
    }

}

