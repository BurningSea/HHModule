//
//  ViewController.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class RootViewController: UIViewController {
    var weakDependencies: RootWeakDependencies?
    fileprivate var strongDependencies: RootStrongDependencies
    lazy var cancelable = [Cancellable]()
    
    deinit {
        for c in cancelable {
            c.cancel()
        }
    }
    
    init(_ deps: RootStrongDependencies) {
        strongDependencies = deps
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button1 = UIButton(type: .custom)
        button1.setTitle("VC1", for: .normal)
        cancelable.append(button1.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else {
                return
            }
            guard let vc1 = self.weakDependencies?.vc1() else {
                return
            }
            
            print("Push VC1 \(vc1)")
            self.navigationController?.pushViewController(vc1, animated: true)
        })
        
        let button2 = UIButton(type: .custom)
        button2.setTitle("VC2", for: .normal)
        cancelable.append(button2.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else {
                return
            }
            guard let vc2 = self.weakDependencies?.vc2() else {
                return
            }
            print("Push VC2 \(vc2)")
            self.navigationController?.pushViewController(vc2, animated: true)
        })
        
        let button3 = UIButton(type: .custom)
        button3.setTitle("Service1", for: .normal)
        cancelable.append(button3.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else {
                return
            }
            guard let service1 = self.weakDependencies?.service1() else {
                return
            }
            service1.foo()
        })
        
        let button4 = UIButton(type: .custom)
        button4.setTitle("Service2", for: .normal)
        cancelable.append(button4.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else {
                return
            }
            guard let service2 = self.weakDependencies?.service2() else {
                return
            }
            service2.foo()
        })
        
        let button5 = UIButton(type: .custom)
        button5.setTitle("Service21", for: .normal)
        cancelable.append(button5.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else {
                return
            }
            guard let service21 = self.weakDependencies?.service21() else {
                return
            }
            service21.foo()
        })
        
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4, button5])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }
}

