//
//  AnyStep.swift
//  Muserval
//
//  Created by Georges Boumis on 16/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct AnyStep: Step {
	public let value: Int
	public init(step: Int) {
		self.value = step
	}
	public static func derive(step: Int) -> Step {
		switch step {
		case 1:
			return Semitone()
		case 2:
			return Tone()
		default:
			return AnyStep(step: step)
		}
	}
 }

extension AnyStep: ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = Int
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(step: value)
	}
}

extension AnyStep: CustomStringConvertible {
	public var description: String {
		return "semitones<\(self.value)>"
	}
}
