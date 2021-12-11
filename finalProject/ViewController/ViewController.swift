//
//  ViewController.swift
//  finalProject
//
//  Created by Seak Yith on 11/26/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var sIgnUpButton: UIButton!
    @IBOutlet var LogInWithYourAccount: UIButton!
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylebutton(button: logInButton, title: "Log In")
        stylebutton(button: sIgnUpButton, title: "Register New User")
        // Do any additional setup after loading the view.
    }
    
    // show video
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    // Set up video for background
    func setUpVideo(){
        
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        
        guard path != nil else{
            return
        }
        let url = URL(fileURLWithPath: path!)
        let videoItem = AVPlayerItem(url: url)
        
        //Create player
        videoPlayer = AVPlayer(playerItem: videoItem)
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //Size
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.7,
                                         y: 0, width: self.view.frame.size.width*4,
                                         height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.5)
        
        
    }

}

