//
//  MainPlayerView.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 17/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

protocol MainPlayerViewDelegate: MiniPlayerViewDelegate {
    func didTapOnDropDownButton()
    func didTapOnPreviousButton()
    func didTapOnNextButton()
}

class MainPlayerView: UIView {

    @IBOutlet weak var playerPlayButton: UIButton!
    @IBOutlet weak var playerPreviouseButton: UIButton!
    @IBOutlet weak var playerNextButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songProgressSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    weak var delegate: MainPlayerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBlurEffect()
    }
    
    private func addBlurEffect() {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.backgroundColor = UIColor.clear
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
            blurView.frame = self.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(blurView)
            sendSubview(toBack: blurView)
        }
    }
    
    @IBAction func didTapOnPlayButton(_ sender: Any) {
        if let _sender = sender as? UIButton {
            delegate?.didTapOnPlayButton(_sender)
        }
    }
    
    @IBAction func didTapOnPreviousButton(_ sender: Any) {
       delegate?.didTapOnPreviousButton()
    }
    
    @IBAction func didTapOnNextButton(_ sender: Any) {
       delegate?.didTapOnNextButton()
    }
    
    @IBAction func didTapOnDropDownButton(_ sender: Any) {
        delegate?.didTapOnDropDownButton()
    }
    
    func updateMainPlayerView(withSong song: Song) {
        songNameLabel.text = song.name
        titleLabel.text = song.name
        songImageView.loadImage(fromURL: song.picture.url)
    }
}
