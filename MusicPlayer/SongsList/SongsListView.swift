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
    var songsList: [Song] = []
    var playerView: PlayerView?
    var playerViewTopConstraint: NSLayoutConstraint?
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }

    private func configureTableView() {
        tableView.register(UINib(nibName: String(describing: SongsListTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: SongsListTableViewCell.self))
        tableView.tableFooterView = UIView()
    }
    
    private func configurePlayerView() {
        if let _playerView = PlayerView().loadNib(withName: String(describing: PlayerView.self)) as? PlayerView {
            _playerView.delegate = self
            playerView = _playerView
        }
    }
    
    private func displayPlayerView(forSong song: Song) {
        configurePlayerView()
        if let _playerView = playerView {
            addSubview(_playerView)
            bringSubview(toFront: _playerView)
            addPlayerViewConstraints()
            _playerView.playSong(song)
        }
    }
    
    private func removePlayerView() {
        playerView?.pauseSong()
        playerView?.removeFromSuperview()
        playerView = nil
        playerViewTopConstraint = nil
    }
    
    private func addPlayerViewConstraints() {
        if let _playerView = playerView {
            _playerView.translatesAutoresizingMaskIntoConstraints = false
            let leadingConstraint = _playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            let topConstraint = _playerView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -(Constants.miniPlayerViewToptConstant))
            let widthConstraint = _playerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0)
            let heightConstraint = _playerView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: Constants.mainPlayerViewHeightConstant)
            addConstraints([leadingConstraint, topConstraint, widthConstraint, heightConstraint])
            playerViewTopConstraint = topConstraint
        }
    }
    
    private func presentPlayerView(withAnimation animate:Bool, isMiniPalyer: Bool) {
        if let _constraint = playerViewTopConstraint {
             removeConstraint(_constraint)
        }
        if animate {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.layoutMainPlayerView(shouldMinimize: isMiniPalyer)
            }, completion: nil)
        } else {
           layoutMainPlayerView(shouldMinimize: isMiniPalyer)
        }
    }
    
    func layoutMainPlayerView(shouldMinimize: Bool) {
        if shouldMinimize {
            self.playerViewTopConstraint = self.playerView?.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -(Constants.miniPlayerViewToptConstant))
        } else {
            self.playerViewTopConstraint = self.playerView?.topAnchor.constraint(equalTo: self.topAnchor, constant: -(Constants.mainPlayerViewHeightConstant))
        }
        self.playerViewTopConstraint?.isActive = true
        self.layoutIfNeeded()
    }
    
    
    func updateView(WithSongs songs: [Song]) {
        songsList = songs
        tableView.reloadData()
    }
    
}

extension SongsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.songsListCellHeight
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
    func didTapOnPlayButton(ForSong song: Song) {
        if let _ = playerView {
            removePlayerView()
        } else {
            displayPlayerView(forSong: song)
        }
    }
}

extension SongsListView: PlayerViewDelegate {
    func displayMainPlayerView() {
        presentPlayerView(withAnimation: true, isMiniPalyer: false)
    }
    
    func dismissMainPlayerView() {
        presentPlayerView(withAnimation: true, isMiniPalyer: true)
        removePlayerView()
    }
    
    func displayMiniPlayerView() {
        presentPlayerView(withAnimation: true, isMiniPalyer: true)
    }
}
