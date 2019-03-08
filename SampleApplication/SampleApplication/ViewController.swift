//
//  ViewController.swift
//  SampleApplication
//
//

import UIKit
import CameraFramework
import NetworkFramework
import UtilityFramework

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactView: contactView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Framework Version: \(CameraViewController.getVersion()!)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        //contactView.label1.text = "From Code."
        //contactView.isHidden = true
        
        /*
         Test the Network facility
         */
//        let myLoader: ViewModel = ViewModel(dataTaskState: .active, extra_resonse_delay_milliseconds: 0)
//        myLoader.dataTask(method: .GET, sURL: "https://api.github.com/users/mralexgray/repos", headers: nil, body: nil) { (success, dictResponse) in
//            print(dictResponse)
//        }
        
        /*
            Test View Extention.
         !!!!!!!!!:
         1. in the Nib file, we need to set the type of the view (contactView.nib) to contactView rather than UIView (nor XibView)
         2. In the Nib file of the view, connect the outlet to the view, and not the file owner.
         https://stackoverflow.com/questions/51056322/load-xib-this-class-is-not-key-value-coding-compliant-for-the-key
         */
//        self.contactView.isHidden = true
//
//        let myContactView: contactView = UIView.fromNib()
//        //myContactView.frame = CGRect(x: myContactView.frame.origin.x, y: myContactView.frame.origin.y, width: 300, height: 150)
//        myContactView.label1.text = "successfully loaded from a Nib file."
//        self.view.addSubview(myContactView)

//        let myView: UIView = XibView.fromNib(nibName: "View")
//        myView.frame = CGRect(x: myContactView.frame.origin.x, y: myContactView.frame.origin.y + myContactView.frame.height, width: myView.frame.width, height: myView.frame.height)
//        self.view.addSubview(myView)
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
