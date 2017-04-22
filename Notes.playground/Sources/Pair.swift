//
//  Pair.swift
//  Muserval
//
//  Created by Georges Boumis on 15/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct Pair<E> where E: Hashable {
	public let a: E
	public let b: E

	public init(a: E, b: E) {
		self.a = a
		self.b = b
	}
}

extension Pair: Hashable {
	public static func ==(lhs: Pair<E>, rhs: Pair<E>) -> Bool {
		return (lhs.hashValue == rhs.hashValue)
	}

	public var hashValue: Int {
		var hash = 11
		hash = Int.addWithOverflow(hash, Int.multiplyWithOverflow(self.a.hashValue, 33).0).0
		hash = Int.addWithOverflow(hash, Int.multiplyWithOverflow(self.b.hashValue, 17).0).0
		return hash
	}
}

extension Pair: CustomStringConvertible {
	public var description: String {
		return "<\(self.a),\(self.b)>"
	}
}

extension Pair: CustomPlaygroundQuickLookable {
	public var customPlaygroundQuickLook: PlaygroundQuickLook {
		return PlaygroundQuickLook.text(self.description)
	}
}

public extension Pair where E: Equatable {
	public func contains(_ element: E) -> Bool {
		return (self.a == element) || (self.b == element)
	}
}
