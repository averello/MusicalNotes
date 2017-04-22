//
//  Semitone.swift
//  Muserval
//
//  Created by Georges Boumis on 16/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct Semitone: Step {
	public let value: Int = 1
	public init() {

	}
}

extension Semitone: CustomStringConvertible {
	public var description: String {
		return "semitone<1>"
	}
}
