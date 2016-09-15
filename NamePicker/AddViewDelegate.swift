//
//  AddViewDelegate.swift
//  NamePicker
//
//  Created by Emily Lynam on 9/14/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation

protocol AddViewProtocolDelegate: class {
    func addViewController(_ controller: AddViewController, didFinishAddingName name: String)
}
