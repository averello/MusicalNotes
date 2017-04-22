//
//  Tone.swift
//  Muserval
//
//  Created by Georges Boumis on 16/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct Tone: Step {
	public let value: Int = 2 * Semitone().value
	public init() {

	}
}

extension Tone: CustomStringConvertible {
	public var description: String {
		return "tone<2>"
	}
}
