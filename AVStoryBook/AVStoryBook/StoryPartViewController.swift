//
//  ViewController.swift
//  AVStoryBook
//
//  Created by MINA FUJISAWA on 2017/10/17.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit
import FontAwesome
import AVFoundation
import Photos

class StoryPartViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var editImageBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    let fileManager = FileManager()
    let fileName = "sample.caf"
    var page: Page!
    var pageIndex: Int!

    let imagePicker = UIImagePickerController()

    @IBAction func editImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: image view
        imageView.image = page.image
        imagePicker.delegate = self
        

        // MARK: set icons
        editImageBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        editImageBtn.setTitle(String.fontAwesomeIcon(name: .camera), for: .normal)

        recordButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        recordButton.setTitle(String.fontAwesomeIcon(name: .microphone), for: .normal)

        //MARK: AV
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordButton.addTarget(self, action: #selector(self.recordTapped), for: .touchUpInside)
                    } else {
                        print("failed to record!")
                    }
                }
            }
        } catch {
            print("failed to record!")
        }
    }

    //MARK: Record
    func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: getDocumentFilePath(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            recordButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
            recordButton.setTitle(String.fontAwesomeIcon(name: .stop), for: .normal)

        } catch {
            finishRecording(success: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let pageVC = PageViewController()
        pageVC.pages[pageIndex] = page
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func getDocumentFilePath() -> URL {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask) as [NSURL]
        let dirURL = urls[0]
        return dirURL.appendingPathComponent(fileName)!
    }

    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        recordButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        recordButton.setTitle(String.fontAwesomeIcon(name: .microphone), for: .normal)

        if !success {
            print("recording failed")
        }
    }

    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }

    // MARK : Play
    func play() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: self.getDocumentFilePath())
        } catch {
            print("Error to play")
        }
        audioPlayer?.play()
    }


}

extension StoryPartViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

extension StoryPartViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        page.image = image
        imageView.image = page.image
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

