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

class secondVC: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer!
    let soundURL = Bundle.main.url(forResource: "manyDicesSound", withExtension: "WAV")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let randomFirstDiceIndex = Int(arc4random_uniform(6))+1
            let randomSecondDiceIndex = Int(arc4random_uniform(6))+1
            self.imageFirstDice.image = UIImage(named: "dice\(randomFirstDiceIndex).png")!
            self.imageSecondDice.image = UIImage(named: "dice\(randomSecondDiceIndex).png")!
            let sumRandom = randomFirstDiceIndex + randomSecondDiceIndex
            messageLabel.text = ("Your result is \(sumRandom)")
            if sumRandom == 12 {messageLabel.text = "Congratulations!"}

        }
    }

    @IBOutlet weak var imageFirstDice: UIImageView!

    @IBOutlet weak var imageSecondDice: UIImageView!

    @IBOutlet weak var messageLabel: UITextField!

    @IBAction func shakeDiceBtn(_ sender: UIButton) {

        try! audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer.play()

        self.messageLabel.text = ""

        self.imageFirstDice.shake(duration: 0.08, shakeCount: 2)
        self.imageSecondDice.shake(duration: 0.08, shakeCount: 2)

        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            randomizeCubes()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }

        func randomizeCubes() {

            let randomFirstDiceIndex = Int(arc4random_uniform(6))+1
            let randomSecondDiceIndex = Int(arc4random_uniform(6))+1
            self.imageFirstDice.image = UIImage(named: "dice\(randomFirstDiceIndex).png")!
            self.imageSecondDice.image = UIImage(named: "dice\(randomSecondDiceIndex).png")!
            let sumRandom = randomFirstDiceIndex + randomSecondDiceIndex
            messageLabel.text = ("Your result is \(sumRandom)")
            if sumRandom == 12 {messageLabel.text = "Congratulations!"}
        }

    }

    


}
