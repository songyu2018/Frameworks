/**
 */

import UIKit
import AVFoundation

class GestureRecognizerController: UIViewController {
  
  @IBOutlet var panGR: UIPanGestureRecognizer!
  
  var chompPlayer:AVAudioPlayer? = nil
  var hehePlayer:AVAudioPlayer? = nil
  
  func loadSound(filename: String) -> AVAudioPlayer {
    let url = Bundle.main.url(forResource: filename, withExtension: "caf")
    var player = AVAudioPlayer()
    do {
      try player = AVAudioPlayer(contentsOf: url!)
      player.prepareToPlay()
    } catch {
      print("Error loading \(url!): \(error.localizedDescription)")
    }
    return player
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //1
    let filteredSubviews = self.view.subviews.filter({
      $0 is UIImageView })
    //2
    for view in filteredSubviews  {
      //3
      let recognizer = UITapGestureRecognizer(target: self,
                                              action:#selector(handleTap(recognizer:)))
      //4
      recognizer.delegate = self
      view.addGestureRecognizer(recognizer)
      
      // The tap gesture recognizer will only get called if no pan is detected.
      recognizer.require(toFail: panGR)
      
        
      //TODO: Add a custom gesture recognizer too
      let recognizer2 = TickleGestureRecognizer(target: self,
                                                action:#selector(handleTickle(recognizer:)))
      recognizer2.delegate = self
      view.addGestureRecognizer(recognizer2)
    }
    self.chompPlayer = self.loadSound(filename: "chomp")
    
    self.hehePlayer = self.loadSound(filename: "hehehe1")
  }
  
  @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
    // Retrieve the amount the user has moved their finger.
    let translation = recognizer.translation(in: self.view)
    
    // Use that amount to move the center of the monkey the same amount
    // the finger has been dragged.
    if let view = recognizer.view {
      view.center = CGPoint(x:view.center.x + translation.x,
                            y:view.center.y + translation.y)
    }
    // It’s important to set the translation back to zero once you are done.
    // Otherwise, the translation will keep compounding each time,
    // and you’ll see your monkey rapidly move off the screen!
    recognizer.setTranslation(CGPoint.zero, in: self.view)
    
    
    if recognizer.state == UIGestureRecognizer.State.ended {
      // 1. Figure out the length of the velocity vector (i.e. the magnitude)
      let velocity = recognizer.velocity(in: self.view)
      let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
      let slideMultiplier = magnitude / 200
      print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
      
      // 2. If the length is < 200, then decrease the base speed, otherwise increase it.
      let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
      // 3. Calculate a final point based on the velocity and the slideFactor.
      var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                               y:recognizer.view!.center.y + (velocity.y * slideFactor))
      // 4. Make sure the final point is within the view’s bounds
      finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
      finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
      
      // 5. Animate the view to the final resting place.
      UIView.animate(withDuration: Double(slideFactor * 2),
                     delay: 0,
                     // 6. Use the “ease out” animation option to slow down the movement over time.
        options: UIView.AnimationOptions.curveEaseOut,
        animations: {recognizer.view!.center = finalPoint },
        completion: nil)
    }
  }
  
  @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
    if let view = recognizer.view {
      view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
      recognizer.scale = 1
    }
  }
  
  @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
    if let view = recognizer.view {
      view.transform = view.transform.rotated(by: recognizer.rotation)
      recognizer.rotation = 0
    }
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    self.chompPlayer?.play()
  }
  
  @objc func handleTickle(recognizer: TickleGestureRecognizer) {
    self.hehePlayer?.play()
  }
  
}

extension GestureRecognizerController: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
}
