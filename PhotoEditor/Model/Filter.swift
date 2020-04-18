//
//  Filter.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 10/25/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import Foundation
import GPUImage

 //MARK: - struct PEFilter

struct PEFilter {
    let name: String
    let gpuFilter: GPUImageFilter
}
