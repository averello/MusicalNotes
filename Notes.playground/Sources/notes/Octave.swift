//
//  Octave.swift
//  Muserval
//
//  Created by Georges Boumis on 15/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct Octave {
	public let identifier: Int
	public init(identifier: Int) {
		self.identifier = identifier
		let all = Note.Name.All()
		var notes = all.map { (note) -> Note in
			return Note(note, octave: self)
		}

		notes.append(contentsOf: notes.map { (note) -> Note in
			return note.with(alt: Note.Alteration.sharp)
		})
		notes.append(contentsOf: notes.map { (note) -> Note in
			return note.with(alt: Note.Alteration.flat)
		})
		self._notes = notes
	}

	public var notes: [Note] {
		return self._notes
	}
	fileprivate var _notes: [Note] = []
}

extension Octave: Collection {
	private typealias StoreType = Array<Note>
	public typealias Element = StoreType.Element
	public typealias Index = StoreType.Index

	public var startIndex: Index { return self._notes.startIndex }
	public var endIndex: Index { return self._notes.startIndex }
	public var count: StoreType.IndexDistance { return self._notes.count }
	public subscript(i: Index) -> Element { return self._notes[i] }

	public func index(_ i: Index, offsetBy n: Int) -> Index {
		return self._notes.index(i, offsetBy: n)
	}

	public func index(after i: Index) -> Index {
		return self._notes.index(after: i)
	}

	public func contains(_ element: Note) -> Bool {
		return element.octave == self
	}
}

extension Octave: Equatable {
	public static func == (lhs: Octave, rhs: Octave) -> Bool {
		return (lhs.identifier == rhs.identifier)
	}
}

extension Octave: CustomStringConvertible {
	public var description: String {
		return "Octave<\(self.identifier)>: \(self._notes);"
	}
}
