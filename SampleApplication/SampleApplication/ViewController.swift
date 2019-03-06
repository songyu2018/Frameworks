//
//  ViewController.swift
//  SampleApplication
//
//

import UIKit
import CameraFramework
import NetworkFramework


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Framework Version: \(CameraViewController.getVersion()!)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonTapped() {
        let camera = CameraViewController.init()
        camera.delegate = self
        camera.position = .back
        present(camera, animated: true, completion: nil)
        
        /*
         Test the Network facility
         */
        let myLoader: ViewModel = ViewModel(dataTaskState: .active, extra_resonse_delay_milliseconds: 0)
        myLoader.dataTask(method: .GET, sURL: "https://api.github.com/users/mralexgray/repos", headers: nil, body: nil) { (success, dictResponse) in
            print(dictResponse)
        }
    }

}

extension ViewController: CameraControllerDelegate {
    func stillImageCaptured(controller: CameraViewController, image: UIImage) {
        self.imageView.image = image
        controller.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonTapped(controller: CameraViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
