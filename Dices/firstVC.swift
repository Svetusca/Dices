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

class firstVC: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer!
    let soundURL = Bundle.main.url(forResource: "oneDiceSound", withExtension: "WAV")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let randomDiceIndex = Int(arc4random_uniform(6))+1
            self.imageDice.image = UIImage(named: "dice\(randomDiceIndex).png")!
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }

    @IBOutlet weak var messageLabel: UITextField!

    @IBOutlet weak var imageDice: UIImageView!

    @IBAction func shakeDiceBtn(_ sender: UIButton) {

        try! audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer.play()

        self.messageLabel.text = ""

        self.imageDice.shake(duration: 0.08, shakeCount: 2)

        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            let randomDiceIndex = Int(arc4random_uniform(6))+1
            self.imageDice.image = UIImage(named: "dice\(randomDiceIndex).png")!
            if randomDiceIndex == 6 {self.messageLabel.text = "Congratulations!"}
        }



    }



}
