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
    
    func songTotalDuration() -> String {
        let totalDuration = ""
        if let duration = player?.currentItem?.asset.duration {
            let seconds = CMTimeGetSeconds(duration)
            return totalDuration.readableTimeFormat(forDuration: seconds)
        }
        return totalDuration
    }
    
    func songCurrentDuration() -> String {
        let currentDuration = ""
        if let duration = player?.currentTime() {
            let seconds = CMTimeGetSeconds(duration)
            return currentDuration.readableTimeFormat(forDuration: seconds)
        }
        return currentDuration
    }
    
    func playSong(_ song: Song) {
        miniplayerView.updateView(withSong: song)
        mainPlayerView.updateMainPlayerView(withSong: song)
        configureAVPlayer(WithURL: song.audioLink)
        playSong()
    }
    
    private func playSong() {
        player?.play()
        
        //Configure Play buttons
        miniplayerView.playButton.isSelected = true
        mainPlayerView.playerPlayButton.isSelected = true
        
        //Configure seekbar
        if let duration = player?.currentItem?.asset.duration {
            mainPlayerView.songProgressSlider.value = 0
            mainPlayerView.songProgressSlider.minimumValue = 0
            mainPlayerView.songProgressSlider.maximumValue = Float(CMTimeGetSeconds(duration))
            self.mainPlayerView.totalTimeLabel.text = songTotalDuration()
        }
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main, using: { (time) in
            if let duration = self.player?.currentTime() {
                self.mainPlayerView.songProgressSlider.value = Float(CMTimeGetSeconds(duration))
                self.mainPlayerView.currentTimeLabel.text = self.songCurrentDuration()
            }
            
        })
    }
    
    func pauseSong() {
        player?.pause()
        miniplayerView.playButton.isSelected = false
        mainPlayerView.playerPlayButton.isSelected = false
    }
}

extension PlayerView: MiniPlayerViewDelegate {
    func didTapOnMoreButton(_ sender: UIButton) {
         delegate?.displayMainPlayerView()
    }
    
    func didTapOnPlayButton(_ sender: UIButton) {
        if sender.isSelected {
            pauseSong()
        } else {
            playSong()
        }
    }
}

extension PlayerView: MainPlayerViewDelegate {
    func didTapOnDropDownButton() {
        delegate?.displayMiniPlayerView()
    }
    
    func didTapOnNextButton() {
        
    }
    
    func didTapOnPreviousButton() {
        
    }
}
