//
//  ViewController.swift
//  LayoutManager
//
//  Created by Tim Beals on 2017-03-24.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()

    
    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        view.addSubview(yellowView)
        view.addSubview(greenView)
        view.addSubview(redView)

        let size = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        if UIDevice.current.orientation.isLandscape {
            setupViewsLandscape(withSize: size)
        } else {
            setupViewsPortrait(withSize: size)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        let navController = self.navigationController
        navController?.navigationBar.isTranslucent = true
    }
    
    func setupViewsLandscape(withSize size: CGSize) {
        
        let navHeight = (navigationController?.navigationBar.frame.height)!
        
        yellowView.frame = CGRect(x: 20, y: navHeight + 20, width: view.bounds.width / 2 - 30, height: view.bounds.height - 40 - navHeight)
        
        greenView.frame = CGRect(x: 40 + yellowView.frame.width, y: 20 + navHeight, width: yellowView.frame.width / 2 - 10, height: yellowView.frame.height)
        
        redView.frame = CGRect(x: greenView.frame.maxX + 20, y: greenView.frame.minY, width: greenView.frame.width, height: greenView.frame.height)
    }
    
    
    func setupViewsPortrait(withSize size: CGSize) {
        
        let navHeight = (navigationController?.navigationBar.frame.height)! + 20 //extra 20 for status bar height

        yellowView.frame = CGRect(x: 20, y: navHeight + 20, width: size.width - 40, height: (size.height - navHeight) / 2 - 30)
        
        greenView.frame = CGRect(x: 20, y: 40 + yellowView.frame.height + navHeight, width: size.width / 2 - 30, height: yellowView.frame.height)
        
        redView.frame = CGRect(x: 40 + greenView.frame.width, y: greenView.frame.minY, width: greenView.frame.width, height: greenView.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            
            coordinator.animate(alongsideTransition: nil, completion: {
                _ in
                
                self.setupViewsLandscape(withSize: size)
            })
        } else {
            coordinator.animate(alongsideTransition: nil, completion: {
                _ in
                self.setupViewsPortrait(withSize: size)
            })
        }
    }
}

