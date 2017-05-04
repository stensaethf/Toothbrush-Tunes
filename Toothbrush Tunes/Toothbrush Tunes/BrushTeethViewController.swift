//
//  DirtyTeethViewController.swift
//  Toothbrush Tunes
//
//  Created by Frederik Stensæth on 12/9/16.
//  Copyright © 2016 Frederik Roenn. All rights reserved.
//

import AVFoundation
import UIKit

class BrushTeethViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var character:String!
    var isAlive:Bool!
    
    @IBOutlet var mouthImageView: UIImageView!
    @IBOutlet var mouth2DImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // show navigation bar
        self.navigationController?.navigationBar.isHidden = false
        isAlive = true
        
        displayDirtyMouth()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // kill animation and audio
        isAlive = false
        audioPlayer.stop()
    }
    
    @IBAction func startSong(_ sender: UIButton) {
        // hide dirty mouth and start song button
        mouthImageView.isHidden = true
        sender.isHidden = true
        
        // show 2d mouth and play song
        playMouth2DAnimation(frame: 0)
        mouth2DImageView.isHidden = false
        playAudio(audioFile: "BrushTeethSong")
    }
    
    func playAudio(audioFile: String) {
        guard let sound = NSDataAsset(name: audioFile) else {
            print("Audio file not found")
            return
        }
        
        do {
            // Remove deprecated use of AVAudioSessionDelegate protocol
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func playMouth2DAnimation(frame: Int) {
        if (isAlive == true) {
            if (mouth2DImageView.isAnimating) {
                mouth2DImageView.stopAnimating()
            }
            
            var animationImages: [UIImage] = []
            for i in frame...frame+1 {
                animationImages.append(UIImage(named: "Mouth2D\(i)")!)
            }
            mouth2DImageView.animationImages = animationImages
            mouth2DImageView.animationDuration = 1.5
            mouth2DImageView.startAnimating()
            
            if (frame < 3) {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(27), execute: {
                        self.playMouth2DAnimation(frame: frame + 1)
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(27), execute: {
                    self.mouth2DImageView.stopAnimating()
                    self.displayCleanMouth()
                    self.mouth2DImageView.isHidden = true
                    self.mouthImageView.isHidden = false
                })
            }
        }
    }
    
    func displayDirtyMouth() {
        switch (character) {
            case "Isabella":
                mouthImageView.image = UIImage(named: "IsabellaDirtyMouth")
                playAudio(audioFile: "IsabellaDirtyAudio")
            case "Freddie":
                mouthImageView.image = UIImage(named: "FreddieDirtyMouth")
                playAudio(audioFile: "FreddieDirtyAudio")
            case "Lilly":
                mouthImageView.image = UIImage(named: "LillyDirtyMouth")
                playAudio(audioFile: "LillyDirtyAudio")
            default:
                print("Invalid character")
        }
    }
    
    func displayCleanMouth() {
        switch (character) {
            case "Isabella":
                mouthImageView.image = UIImage(named: "IsabellaCleanMouth")
                playAudio(audioFile: "IsabellaCleanAudio")
            case "Freddie":
                mouthImageView.image = UIImage(named: "FreddieCleanMouth")
                playAudio(audioFile: "FreddieCleanAudio")
            case "Lilly":
                mouthImageView.image = UIImage(named: "LillyCleanMouth")
                playAudio(audioFile: "LillyCleanAudio")
            default:
                print("Invalid character")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
