//
//  FillInBlankViewContriller.swift
//  SampleApplication
//
//  Created by Nicky on 2019-03-29.
//  Copyright © 2019 David Okun. All rights reserved.
//

import Foundation
import UIKit

class FillInBlankViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.spellCheckingType = .no
       
        self.drawBlankBoxes()
        
        loopup(sWork: "good")
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
    func loopup(sWork: String) {
        let myLoader: ViewModel = ViewModel(dataTaskState: .active, extra_resonse_delay_milliseconds: 0)
        myLoader.dataTask(method: .GET, sURL: "https://od-api.oxforddictionaries.com/api/v1/entries/en/change/translations=tn", headers: ["Accept":"application/json", "app_id":"36657328", "app_key":"df95d34ce6c52d9ac2f25418d760adb7"], body: nil) { (success, dictResponse) in
            //print(dictResponse)
            
            if let response = dictResponse["__RESPONSE__"]{
                do {
                    let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let model = try JSONDecoder().decode(Dictionary.self, from: data)
                    print(model.metadata?.provider ?? "Error")
                    print(model.results?[0].lexicalEntries?[0].entries?[0].grammaticalFeatures?[0].text ?? "Error")
                } catch { print(error) }
            }
        }
    }
    
    
    func drawBlankBoxes() {
        var array = [String]()
        
        array = ["WORD1", "PLACEHOLDER", "WORD2", "WORD3", "WORD4", "WORD4", "LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONGWORD", "WORD5"]
        
        var stringarr = String()
        
        for i in 0...(array.count-1) {
            
            if array[i].count > 20 {
                let count = array[i].count
                let dropCount = count-20
                let dropCharacters = array[i].dropLast(dropCount)
                var shortenedWord = "\(dropCharacters)"
                shortenedWord = "\(shortenedWord)..."
                print(shortenedWord)
                array[i] = shortenedWord
                
            }
        }
        
        stringarr = array.joined(separator: " ")
        
        
        func frameOfTextInRange(range:NSRange, inTextView textView:UITextView) -> CGRect {
            let beginning = textView.beginningOfDocument
            let start = textView.position(from: beginning, offset: range.location)
            let end = textView.position(from: start!, offset: range.length)
            let textRange = textView.textRange(from: start!, to: end!)
            let rect = textView.firstRect(for: textRange!)
            
            return textView.convert(rect, from: textView)
        }
        
        
        textView.backgroundColor = UIColor.clear
        
        let lineSpacing: CGFloat = 0.0
        
        textView.attributedText = {
            let attributedString = NSMutableAttributedString(string: stringarr)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.5
            paragraphStyle.lineSpacing = lineSpacing
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: stringarr.count))
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: stringarr.count))
            attributedString.addAttribute(.font, value: UIFont(name: "AvenirNext-Regular", size: 20.0)!, range: NSRange(location: 0, length: stringarr.count))
            
            
            let regex = try! NSRegularExpression(pattern: "\\s", options: [])
            let matches = regex.matches(in: stringarr, options: [], range: NSRange(location: 0, length: stringarr.count))
            
            for m in matches {
                attributedString.addAttribute(.kern, value: 6, range: m.range)
            }
            
            return NSAttributedString(attributedString: attributedString)
        }()
        
        
        textView.textAlignment = .center
        
        let textViewBG = UIView(frame: textView.bounds)
        textViewBG.backgroundColor = UIColor.white
        
        let pattern = "PLACEHOLDER"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: stringarr, options: [], range: NSRange(location: 0, length: stringarr.count))
        
        for m in matches {
            textView.addSubview({
                let range = m.range
                let frame = frameOfTextInRange(range: range, inTextView: textView).insetBy(dx: CGFloat(-2), dy: CGFloat(3)).offsetBy(dx: CGFloat(0), dy: CGFloat(3))
                let v = UITextView(frame: frame)
                v.layer.cornerRadius = 0
                v.layer.borderColor = UIColor.red.cgColor
                v.layer.borderWidth = 1
                //v.backgroundColor = UIColor.black
                
                v.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:))))
                
                return v
            }())
        }
    }
    
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        print("triggered!")
        let view = sender.view as? UITextView
        view?.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        view?.textAlignment = .center
        view?.textColor = UIColor.lightGray
        view?.text = "selected"
    }

}
