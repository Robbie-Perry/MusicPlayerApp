//
//  ViewController.swift
//  Music Player
//
//  Created by Robbie Perry on 2018-04-13.
//  Copyright © 2018 Robbie Perry. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    let songNames = ["Error, you fucking idiot", "ABBA - Take A Chance On Me", "Tom Lehrer - New Math", "The Ramones, - I Wanna Be Sedated", "Jonathan Coulten - Re: My Mind", "Rick Astley - Never Gonna Give You Up"]
    var songNumber = 1
    var songSpeed = 1
    var playbackRate = Float(1.0)
    var songPlayer = AVAudioPlayer()
    var isPlaying = false
    var myUtterance = AVSpeechUtterance(string: "")
    var synth: AVSpeechSynthesizer!
    var timer = Timer()
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var speedButton: UIButton!
    @IBOutlet weak var timePlayed: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synth = AVSpeechSynthesizer()
        synth.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play() {
        var songName = ""
        
        switch songNumber {
        case 1:
            songName = "03 Take A Chance On Me"
            break;
        case 2:
            songName = "10 New Math"
            break;
        case 3:
            songName = "10 I Wanna Be Sedated"
            break;
        case 4:
            songName = "13 Re_ Your Brains"
            break;
        case 5:
            songName = "Rick Astley - Never Gonna Give You Up"
            break;
        default:
            print("hell")
        }
        
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: songName, ofType: "mp3")!))
            songPlayer.enableRate = true
            songPlayer.rate = Float(playbackRate)
            songPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        isPlaying = true
        songPlayer.play()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting() {
        timePlayed.text = "\(Int(songPlayer.currentTime))"
        timeLeft.text = "\(Int(songPlayer.currentTime.distance(to: songPlayer.duration)))"
    }
    
    func speakAndPlay(songName: String) {
        if (isPlaying) {
            songPlayer.pause()
        }
        myUtterance = AVSpeechUtterance(string: songName)
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        play()
    }

    @IBAction func play1(_ sender: Any) {
        songNumber = 1
        songLabel.text = songNames[songNumber]
        speakAndPlay(songName: songNames[songNumber])
    }
    
    @IBAction func play2(_ sender: Any) {
        songNumber = 2
        songLabel.text = songNames[songNumber]
        speakAndPlay(songName: songNames[songNumber])
    }
    
    @IBAction func play3(_ sender: Any) {
        songNumber = 3
        songLabel.text = songNames[songNumber]
        speakAndPlay(songName: songNames[songNumber])
    }
    
    @IBAction func play4(_ sender: Any) {
        songNumber = 4
        songLabel.text = songNames[songNumber]
        speakAndPlay(songName: songNames[songNumber])
    }
    
    @IBAction func play5(_ sender: Any) {
        songNumber = 5
        songLabel.text = songNames[songNumber]
        speakAndPlay(songName: songNames[songNumber])
    }
    
    @IBAction func next(_ sender: Any) {
        songNumber = songNumber == 5 ? 1 : songNumber + 1
        speakAndPlay(songName: songNames[songNumber])
    }
    
    @IBAction func changeSpeed(_ sender: Any) {
        songSpeed = songSpeed == 2 ? 0 : songSpeed + 1
        
        switch songSpeed {
        case 0:
            speedButton.setTitle("0.5x", for: .normal)
            playbackRate = Float(0.5)
            break;
        case 1:
            speedButton.setTitle("1.0x", for: .normal)
            playbackRate = Float(1.0)
            break;
        case 2:
            speedButton.setTitle("2.0x", for: .normal)
            playbackRate = Float(2.0)
            break;
        default:
            print("hell")
        }
        
        if (isPlaying) {
            songPlayer.rate = playbackRate
        }
    }
}

