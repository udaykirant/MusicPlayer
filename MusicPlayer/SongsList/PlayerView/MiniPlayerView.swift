//
//  MiniPlayerView.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 17/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

protocol MiniPlayerViewDelegate: class {
    func didTapOnMoreButton(_ sender: UIButton)
    func didTapOnPlayButton(_ sender: UIButton)
}
class MiniPlayerView: UIView {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    weak var delegate: MiniPlayerViewDelegate?
    
    @IBAction func didTapOnPlayButton(_ sender: Any) {
        if let _sender = sender as? UIButton {
            delegate?.didTapOnPlayButton(_sender)
        }
    }
    
    @IBAction func didTapOnMoreButton(_ sender: Any) {
        if let _sender = sender as? UIButton {
            delegate?.didTapOnMoreButton(_sender)
        }
    }
    
    func updateView(withSong song: Song) {
        songNameLabel.text = song.name
        authorNameLabel.text = song.author.name
    }
}
