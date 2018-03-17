//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

class SongsListViewController: UIViewController {

    @IBOutlet var songsListView: SongsListView!
    var interactor = SongsListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSongsList()
    }
    
    private func fetchSongsList() {
        interactor.getSongsList { (songs, error) in
            //Performing UI operations on main thread
            DispatchQueue.main.async {
                self.songsListView.updateView(WithSongs: songs)
            }
        }
    }
}

