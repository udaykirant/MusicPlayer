//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import UIKit

class SongsListViewController: UIViewController {

    var interactor = SongsListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getSongsList { (songs) in
            print(songs)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

