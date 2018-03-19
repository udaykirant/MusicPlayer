//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 17/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit
import AVFoundation

protocol PlayerViewDelegate: class {
    func displayMainPlayerView()
    func displayMiniPlayerView()
    func dismissMainPlayerView()
}

class PlayerView: UIView {

    @IBOutlet weak var miniplayerView: MiniPlayerView!
    @IBOutlet weak var mainPlayerView: MainPlayerView!
 
    var player : AVPlayer?
    weak var delegate: PlayerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        miniplayerView.delegate = self
        mainPlayerView.delegate = self
    }
    
    private func configureAVPlayer(WithURL URL: URL) {
        player = AVPlayer(url: URL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
    }
    
    func playSong(withURL url: URL) {
        configureAVPlayer(WithURL: url)
        playSong()
    }
    
    private func playSong() {
        player?.play()
    }
    
    func pauseSong() {
        player?.pause()
    }
}

extension PlayerView: MiniPlayerViewDelegate {
    func didTapOnMoreButton() {
        delegate?.displayMainPlayerView()
    }
}

extension PlayerView: MainPlayerViewDelegate {
    func didTapOnDropDownButton() {
        if #available(iOS 10.0, *) {
            if player?.timeControlStatus == AVPlayerTimeControlStatus.playing {
                delegate?.displayMiniPlayerView()
            } else {
                delegate?.dismissMainPlayerView()
            }
        } else {
            delegate?.dismissMainPlayerView()
        }
    }
}
