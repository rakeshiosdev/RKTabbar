//
//  ViewController.swift
//  RKTabbar
//
//  Created by Rakesh Kumar on 28/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tabButtons: [UIButton]!
    @IBOutlet weak var lineViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView!
    
    var tabOneVC = TabOneViewController()
    var tabTwoVC = TabTwoViewController()
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for button in tabButtons {
            button.addTarget(self, action: #selector(selectTabButton), for: .touchUpInside)
        }
        
        selectTabButton(tabButtons[0])
    }

    fileprivate func defaultColor(){
        for button in tabButtons {
            button.setTitleColor(.black, for: .normal)
        }
    }
    @objc func selectTabButton(_ sender: UIButton){
        defaultColor()
        
        if sender.tag == 100 {
            activeViewController = tabOneVC
        }else{
            activeViewController = tabTwoVC
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            if sender.tag == 100 {
                self.lineViewLeadingConstraint.constant = 0
            }else {
                self.lineViewLeadingConstraint.constant = self.view.frame.width / 2
            }
        })
        
        sender.setTitleColor(.orange, for: .normal)
    }

}


extension ViewController {
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            //Call before removing child  view controller's view from hierarchy
            inActiveVC.willMove(toParent: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            //Call after removing child view controller's view from hiererchy
            inActiveVC.removeFromParent()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            //call before adding child view controller's view as subview
            addChild(activeVC)
            
            activeVC.view.frame = self.containerView.bounds
            self.containerView.addSubview(activeVC.view)
            
            activeVC.didMove(toParent: self)
        }
    }
}
