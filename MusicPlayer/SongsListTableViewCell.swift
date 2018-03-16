//
//  SongsListTableViewCell.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 15/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

protocol SongsListTableViewCellDeleagte: class {
    func didTapOnPlayButton(ForSong song: URL?)
}
class SongsListTableViewCell: UITableViewCell {

    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songTypeLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var songModifiedLabel: UILabel!
    @IBOutlet weak var authorImageviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var playButton: UIButton!
    
    weak var deleagte: SongsListTableViewCellDeleagte?
    var audioURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorImageView.layer.cornerRadius = authorImageviewHeightConstraint.constant/2
        clearData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearData()
    }
    
    private func clearData() {
        songImageView.image = nil
        authorImageView.image = nil
        songTypeLabel.text = nil
        songTitleLabel.text = nil
        authorNameLabel.text = nil
        songModifiedLabel.text = nil
    }
    
    func updateCell(WithSong song: Song) {
        songTitleLabel.text = song.name
        authorNameLabel.text = song.author.name
        songImageView.loadImage(fromURL: song.picture.url)
        authorImageView.loadImage(fromURL: song.author.picture.url)
        audioURL = song.audioLink
    }
    
    @IBAction func didTapOnPlayButton(_ sender: Any) {
        playButton.isSelected = !playButton.isSelected
        deleagte?.didTapOnPlayButton(ForSong: audioURL)
    }
}
