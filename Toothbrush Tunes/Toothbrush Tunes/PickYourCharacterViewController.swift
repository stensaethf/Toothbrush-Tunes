//
//  PickYourCharacterViewController.swift
//  Toothbrush Tunes
//
//  Created by Frederik Stensæth on 12/9/16.
//  Copyright © 2016 Frederik Roenn. All rights reserved.
//

import UIKit

class PickYourCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func IsabellaCharacterPicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "characterPicked", sender: "Isabella")
    }

    @IBAction func FreddieCharacterPicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "characterPicked", sender: "Freddie")
    }
    
    @IBAction func LillyCharacterPicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "characterPicked", sender: "Lilly")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "characterPicked") {
            let brushTeeth:BrushTeethViewController = segue.destination as! BrushTeethViewController
            brushTeeth.character = sender as! String!
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
