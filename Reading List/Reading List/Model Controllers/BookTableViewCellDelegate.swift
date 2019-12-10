//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by patelpra on 12/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableviewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
