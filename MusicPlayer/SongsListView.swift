//
//  SongsListView.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 15/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit
import AVFoundation

class SongsListView: UIView {

    @IBOutlet weak var tableView: UITableView!
    var player : AVPlayer?
    var songsList: [Song] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: String(describing: SongsListTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: SongsListTableViewCell.self))
        tableView.tableFooterView = UIView()
    }
    
    func updateView(WithSongs songs: [Song]) {
        songsList = songs
        tableView.reloadData()
    }
}

extension SongsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.songsListCellHeight)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let songsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SongsListTableViewCell.self),
                                                                      for: indexPath) as? SongsListTableViewCell {
            songsListTableViewCell.deleagte = self
            songsListTableViewCell.updateCell(WithSong: songsList[indexPath.row])
            return songsListTableViewCell
        }
        return UITableViewCell()
    }
}

extension SongsListView: SongsListTableViewCellDeleagte {
    func didTapOnPlayButton(ForSong song: URL?) {
        if let _player = player {
            _player.pause()
            player = nil
        } else {
            if let url = song {
                player = AVPlayer(url: url)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.bounds
                self.layer.addSublayer(playerLayer)
                player?.play()
            }
        }
        
    }
}
