//
//  one_diceVC.swift
//  Dices
//
//  Created by Svetusca on 1/11/18.
//

import Foundation
import UIKit
import Darwin
import AudioToolbox
import AVFoundation

class FirstVC: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer!
    let soundURL = Bundle.main.url(forResource: "oneDiceSound", withExtension: "WAV")
    let randomFirstDiceIndex = 0

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageDice: UIImageView!

    override func becomeFirstResponder() -> Bool {
        return true
    }

    //MARK: make hardware vibrate action
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            makeSoundDice()
            updateDiceImage()
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

    func makeSoundDice() {
        try! audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer.play()
    }

    func updateDiceImage() {
        let randomFirstDiceIndex = Int(arc4random_uniform(6))+1
        self.imageDice.image = UIImage(named: "dice\(randomFirstDiceIndex).png")!
        if randomFirstDiceIndex == 6 {
            self.messageLabel.text = "Congratulations!"
        } else {
            self.messageLabel.text = ""
        }
    }
    
    func shakeDice() {
        self.imageDice.shake(duration: 0.08, shakeCount: 2)
    }
}
