//
//  GenericViewController.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit

class GenericViewController<T: UIView>: UIViewController {
    
  public var rootView: T { return view as! T }
    
  override open func loadView() {
     self.view = T()
  }
    
}
