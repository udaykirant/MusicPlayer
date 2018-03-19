//
//  MiniPlayerView.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 17/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

protocol MiniPlayerViewDelegate: class {
    func didTapOnMoreButton()
}
class MiniPlayerView: UIView {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    weak var delegate: MiniPlayerViewDelegate?
    
    @IBAction func didTapOnPlayButton(_ sender: Any) {
        playButton.isSelected = !playButton.isSelected
    }
    
    @IBAction func didTapOnMoreButton(_ sender: Any) {
        delegate?.didTapOnMoreButton()
    }
}
