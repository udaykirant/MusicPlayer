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
    func playNextSong()
    func playPreviousSong()
    func playSong()
    func didPauseSong()
}

class PlayerView: UIView {

    @IBOutlet weak var miniplayerView: MiniPlayerView!
    @IBOutlet weak var mainPlayerView: MainPlayerView!
 
    var player : AVPlayer?
    var playerLayer : AVPlayerLayer?
    
    weak var delegate: PlayerViewDelegate?
    var currentSong: Song?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        miniplayerView.delegate = self
        mainPlayerView.delegate = self
        mainPlayerView.songProgressSlider.addTarget(self, action: #selector(PlayerView.sliderValueChanged), for: .valueChanged)
         NotificationCenter.default.addObserver(self, selector: #selector(PlayerView.didEndPlay), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private func configureAVPlayer(WithURL URL: URL) {
        if let _playerLayer = self.playerLayer {
            pauseSong()
            player = AVPlayer(url: URL)
            _playerLayer.player = player
            self.playerLayer = _playerLayer
        } else {
            player = AVPlayer(url: URL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.bounds
            self.layer.addSublayer(playerLayer)
            self.playerLayer = playerLayer
        }
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
    
    func songIsPlaying() -> Bool {
        if #available(iOS 10.0, *) {
            return (player?.timeControlStatus == .playing)
        }
        
        return player?.rate != 0 && player?.error == nil
    }
    
    func playSong(_ song: Song) {
        currentSong = song
        miniplayerView.updateView(withSong: song)
        mainPlayerView.updateMainPlayerView(withSong: song)
        configureAVPlayer(WithURL: song.audioLink)
        playSong()
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        pauseSong()
        let value = CMTimeMakeWithSeconds(Float64(sender.value), 1);
        player?.seek(to: value)
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
        delegate?.didPauseSong()
    }
    
    @objc func didEndPlay() {
        pauseSong()
        let value = CMTimeMakeWithSeconds(Float64(0), 1);
        player?.seek(to: value)
        mainPlayerView.songProgressSlider.value = 0
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
        delegate?.playSong()
    }
}

extension PlayerView: MainPlayerViewDelegate {
    func didTapOnDropDownButton() {
        if songIsPlaying() {
            delegate?.displayMiniPlayerView()
        } else {
            delegate?.dismissMainPlayerView()
        }
        
    }
    
    func didTapOnNextButton() {
        delegate?.playNextSong()
    }
    
    func didTapOnPreviousButton() {
        delegate?.playPreviousSong()
    }
}
