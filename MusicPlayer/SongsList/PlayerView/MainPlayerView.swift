//
//  MainPlayerView.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 17/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

protocol MainPlayerViewDelegate: class {
    func didTapOnDropDownButton()
}

class MainPlayerView: UIView {

    @IBOutlet weak var playerPlayButton: UIButton!
    @IBOutlet weak var playerPreviouseButton: UIButton!
    @IBOutlet weak var playerNextButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songProgressView: UIProgressView!
    
    weak var delegate: MainPlayerViewDelegate?
    
    @IBAction func didTapOnPlayButton(_ sender: Any) {
        playerPlayButton.isSelected = !playerPlayButton.isSelected
    }
    
    @IBAction func didTapOnPreviousButton(_ sender: Any) {
       
    }
    
    @IBAction func didTapOnNextButton(_ sender: Any) {
       
    }
    
    @IBAction func didTapOnDropDownButton(_ sender: Any) {
        delegate?.didTapOnDropDownButton()
    }
}
