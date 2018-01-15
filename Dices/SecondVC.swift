//
//  two_dicesVC.swift
//  Dices
//
//  Created by Svetusca on 1/11/18.
//

import Foundation
import UIKit
import Darwin
import AudioToolbox
import AVFoundation

class SecondVC: UIViewController, AVAudioPlayerDelegate {
    let randomFirstDiceIndex = 0
    let randomSecondDiceIndex = 0
    var audioPlayer: AVAudioPlayer!
    let soundURL = Bundle.main.url(forResource: "manyDicesSound", withExtension: "WAV")

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var firstDiceImage: UIImageView!

    @IBOutlet weak var secondDiceImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImage()
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    //MARK: make hardware vibrate action
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            updateDiceImage()
            makeSoundDice()
            shakeDice()
        }
    }

    //MARK: make tap button action
    @IBAction func shakeDiceBtn(_ sender: UIButton) {
        self.messageLabel.text = ""
        makeSoundDice()
        shakeDice()

        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.updateDiceImage()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }

    func updateDiceImage() {
        let randomFirstDiceIndex = Int(arc4random_uniform(6))+1
        firstDiceImage.image = UIImage(named: "dice\(randomFirstDiceIndex).png")!
        let randomSecondDiceIndex = Int(arc4random_uniform(6))+1
        secondDiceImage.image = UIImage(named: "dice\(randomSecondDiceIndex).png")!
        let sumRandom = randomFirstDiceIndex + randomSecondDiceIndex
        if sumRandom == 12 {
            self.messageLabel.text = "Congratulations!"
        } else {
            self.messageLabel.text = "Your result is \(sumRandom)"
        }
    }

    func makeSoundDice() {
        try! audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer.play()
    }

    func shakeDice() {
        self.firstDiceImage.shake(duration: 0.08, shakeCount: 2)
        self.secondDiceImage.shake(duration: 0.08, shakeCount: 2)
    }
}






