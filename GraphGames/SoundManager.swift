//
//  SoundManager.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit
//import AVFoundation
//import AudioToolbox

let soundManager = SoundManager()

enum Sound: String {
	case connect  = "connect.mp3"
	case complete = "complete.mp3"
}

class SoundManager: NSObject {
	
	func playSound(_ sound : Sound) {
		
		guard let isSoundOn = userDefaultManager.getElementForKey("isSoundOn") as? Bool else { return }
		
		if isSoundOn {
			SKAction.playSoundFileNamed(sound.rawValue, waitForCompletion: false)
		}
		return
	}
}

//	var audioPlayer : AVAudioPlayer!
	
//	func playBackgroundSound(sound : Sound) {
//		
//		let soundFilePath = NSBundle.mainBundle().pathForResource(sound.rawValue, ofType: nil)
//		let soundFileURL = NSURL.fileURLWithPath(soundFilePath!)
//		do {
//			try audioPlayer = AVAudioPlayer(contentsOfURL: soundFileURL)
//		} catch {
//			print("Sound not reached.")
//		}
//		audioPlayer.numberOfLoops = -1
//		audioPlayer.prepareToPlay()
//		playBackgroundSound()
//	}
	
//	func playBackgroundSound() {
//		audioPlayer.volume = 0.0
//		audioPlayer.play()
//		
//		if let isSoundOn = userDefaultManager.getElementForKey("isSoundOn") as? Bool {
//			if isSoundOn {
//				doVolumeFadeIn()
//			}
//		}
//	}
	
//	func pauseBackgroundSound() {
//		
//		doVolumeFadeOut()
//		audioPlayer.volume = 0.0
//		audioPlayer.pause()
//	}
	
	
	/* Fade-in/Fade-out da música de fundo */
//	private func doVolumeFadeOut() {
//		if (audioPlayer.volume >= 0.1) {
//			audioPlayer.volume = audioPlayer.volume - 0.1
//			//delay de meio segundo para o volume chegar no mínimo
//			let delay = 0.05 * Double(NSEC_PER_SEC)
//			let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//			dispatch_after(time, dispatch_get_main_queue()) {
//				self.doVolumeFadeOut()
//			}
//		}
//	}
//	private func doVolumeFadeIn() {
//		if (audioPlayer.volume < 1.0) {
//			audioPlayer.volume = audioPlayer.volume + 0.1
//			//delay de meio segundo para o volume chegar no máximo
//			let delay = 0.05 * Double(NSEC_PER_SEC)
//			let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//			dispatch_after(time, dispatch_get_main_queue()) {
//				self.doVolumeFadeIn()
//			}
//		}
//	}
