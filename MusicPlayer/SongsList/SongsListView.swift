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
    
    func previousSong() -> Song {
        if currentSongIndex() == 0 {
            return songsList[songsList.count - 1]
        }
        
        return songsList[currentSongIndex() - 1]
    }
    
    func nextSong() -> Song {
        if currentSongIndex() == songsList.count - 1 {
            return songsList[0]
        }
        
        return songsList[currentSongIndex() + 1]
    }
    
    func currentSongIndex() -> Int {
        if let currentSong = playerView?.currentSong {
            return songsList.index(of: currentSong) ?? 0
        }
        
        return 0
    }
    
    func updatePlaybuttonForCell(withSong song: Song?) {
        guard let _song = song else { return }
        let index = songsList.index(of: _song) ?? 0
        guard let songsListTableViewCell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SongsListTableViewCell else { return }
        if let _currentSong = playerView?.currentSong, _currentSong == _song {
            songsListTableViewCell.playButton.isSelected = playerView?.songIsPlaying() ?? false
        } else {
            songsListTableViewCell.playButton.isSelected = false
        }
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
            let song = songsList[indexPath.row]
            songsListTableViewCell.deleagte = self
            songsListTableViewCell.updateCell(WithSong: song)
            if let _song = playerView?.currentSong, _song == song {
                songsListTableViewCell.playButton.isSelected = playerView?.songIsPlaying() ?? false
            } else {
                    songsListTableViewCell.playButton.isSelected = false
            }
            return songsListTableViewCell
        }
        return UITableViewCell()
    }
}

extension SongsListView: SongsListTableViewCellDeleagte {
    func didTapOnPlayButton(ForSong song: Song, _ sender: UIButton) {
        let previousSong = playerView?.currentSong
        if sender.isSelected {
            removePlayerView()
            updatePlaybuttonForCell(withSong: previousSong)
        } else {
            if let _player = playerView {
                _player.playSong(song)
            } else {
                displayPlayerView(forSong: song)
            }
            updatePlaybuttonForCell(withSong: previousSong)
            updatePlaybuttonForCell(withSong: song)
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
        updatePlaybuttonForCell(withSong: playerView?.currentSong)
    }
    
    func displayMiniPlayerView() {
        presentPlayerView(withAnimation: true, isMiniPalyer: true)
    }
    
    func playPreviousSong() {
        playerView?.playSong(previousSong())
    }
    
    func playNextSong() {
        playerView?.playSong(nextSong())
    }
    
    func playSong() {
        updatePlaybuttonForCell(withSong: playerView?.currentSong)
    }
    
    func didPauseSong() {
        updatePlaybuttonForCell(withSong: playerView?.currentSong)
    }
}
