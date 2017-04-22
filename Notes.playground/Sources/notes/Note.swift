//
//  Note.swift
//  Muserval
//
//  Created by Georges Boumis on 15/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct Note {
	public enum Name: String, CustomStringConvertible {
		case A = "A"
		case B = "B"
		case C = "C"
		case D = "D"
		case E = "E"
		case F = "F"
		case G = "G"

		public var description: String {
			return self.rawValue
		}

		public var next: Note.Name {
			let orderedNotes = Note.Name.Ordered()
			let index = orderedNotes.index(of: self)!
			var nextIndex = orderedNotes.index(after: index)
			if nextIndex >= orderedNotes.endIndex {
				nextIndex = orderedNotes.startIndex
			}
			return orderedNotes[nextIndex]
		}

		public var previous: Note.Name {
			let orderedNotes = Note.Name.Ordered()
			let index = orderedNotes.index(of: self)!
			var previousIndex = orderedNotes.index(index, offsetBy: -1)
			if previousIndex < orderedNotes.startIndex {
				previousIndex = orderedNotes.index(orderedNotes.endIndex, offsetBy: -1)
			}
			return orderedNotes[previousIndex]
		}

		private static let _distances: [Pair<Note.Name> : Step] = [
			Pair<Note.Name>(a: Note.Name.A, b: Note.Name.B) : Tone(),
			Pair<Note.Name>(a: Note.Name.B, b: Note.Name.C) : Semitone(),
			Pair<Note.Name>(a: Note.Name.C, b: Note.Name.D) : Tone(),
			Pair<Note.Name>(a: Note.Name.D, b: Note.Name.E) : Tone(),
			Pair<Note.Name>(a: Note.Name.E, b: Note.Name.F) : Semitone(),
			Pair<Note.Name>(a: Note.Name.F, b: Note.Name.G) : Tone(),
			Pair<Note.Name>(a: Note.Name.G, b: Note.Name.A) : Tone()
		]

		public func steps(to note: Note.Name) -> Step {
			let pair = Pair<Note.Name>(a: self, b: note)

			// if the distance is straight forward then return
			if let d = Note.Name._distances[pair] {
				return d
			}

			// if the same the distance is 0
			if self == note {
				return AnyStep(step: 0)
			}

			// recursions
			let previous = note.previous
			let distanceToPrevious = self.steps(to: previous)
			let distanceOfPreviousToNote = previous.steps(to: note)
			return AnyStep.derive(step: distanceToPrevious.value + distanceOfPreviousToNote.value)
		}

		public func distance(to note: Note.Name) -> Int {
			return self._distance(to: note, total: 0)
		}

		public func _distance(to note: Note.Name, total: Int) -> Int {
			if self == note {
				return total
			}
			return self._distance(to: note.previous, total: total + 1)
		}

		public struct All: Collection {
			private typealias StoreType = Set<Note.Name>
			public typealias _Element = StoreType.Element
			public typealias Element = StoreType.Element
			public typealias Index = StoreType.Index

			public var startIndex: Index { return self.store.startIndex }
			public var endIndex: Index { return self.store.endIndex }
			public var count: StoreType.IndexDistance { return self.store.count }
			public subscript(i: Index) -> Element { return self.store[i] }

			public func index(_ i: Index, offsetBy n: Int) -> Index {
				return self.store.index(i, offsetBy: n)
			}

			public func index(after i: Index) -> Index {
				return self.store.index(after: i)
			}

			private let store: Set<Note.Name> = Set([Note.Name.A,
			                                         Note.Name.B,
			                                         Note.Name.C,
			                                         Note.Name.D,
			                                         Note.Name.E,
			                                         Note.Name.F,
			                                         Note.Name.G])

			public init() {}
		}

		public struct Ordered: Collection, BidirectionalCollection {
			private typealias StoreType = Array<Note.Name>
			public typealias _Element = StoreType.Element
			public typealias Element = StoreType.Element
			public typealias Index = StoreType.Index

			public var startIndex: Index { return self.store.startIndex }
			public var endIndex: Index { return self.store.endIndex }
			public var count: StoreType.IndexDistance { return self.store.count }
			public subscript(i: Index) -> Element { return self.store[i] }

			public func index(_ i: Index, offsetBy n: Int) -> Index {
				return self.store.index(i, offsetBy: n)
			}

			public func index(after i: Index) -> Index {
				return self.store.index(after: i)
			}

			public func index(before i: Index) -> Index {
				return self.store.index(before: i)
			}

			private let store: [Note.Name] = [Note.Name.A,
			                                  Note.Name.B,
			                                  Note.Name.C,
			                                  Note.Name.D,
			                                  Note.Name.E,
			                                  Note.Name.F,
			                                  Note.Name.G]
			public init() {}
		}
	}


	public enum Alteration: String, CustomStringConvertible {
		case flat = "♭"
		case natural = "♮"
		case sharp = "♯"
		case none = ""

		public var description: String {
			return self.rawValue
		}

		public var step: Step {
			switch self {
			case Note.Alteration.flat:
				return AnyStep(step: -1)
			case Note.Alteration.natural, Note.Alteration.none:
				return AnyStep(step: 0)
			case Note.Alteration.sharp:
				return Semitone()
			}
		}

		public func alter(step: Step) -> Step {
			return AnyStep.derive(step: self.step.value + step.value)
		}

		public func alter(note: Note) -> Note {
			switch self {
			case Note.Alteration.flat:
				return note.loweringByOneSemitone
			case Note.Alteration.none:
				return note
			case Note.Alteration.natural:
				let step = note.alteration.step.value
				if step == -1 {
					return note.augmentedByOneSemitone
				}
				else if step == 1 {
					return note.loweringByOneSemitone
				}
				else {
					return note
				}
			case Note.Alteration.sharp:
				return note.augmentedByOneSemitone
			}
		}
	}
	public let name: Note.Name
	public let octave: Octave
	public let alteration: Note.Alteration

	public init(_ name: Note.Name, alt: Note.Alteration = Note.Alteration.none, octave: Octave = Octave(identifier: 0)) {
		self.name = name
		self.octave = octave
		self.alteration = alt
	}
}

extension Note {
	public func with(alt: Note.Alteration) -> Note {
		return Note(self.name, alt: alt, octave: self.octave)
	}

	public func with(octave: Octave) -> Note {
		return Note(self.name, alt: self.alteration, octave: octave)
	}
}

extension Note {
	public var loweringByOneSemitone: Note {
		switch self.alteration {
		case Note.Alteration.flat:
			return Note(self.name.previous, alt: Note.Alteration.none, octave: self.octave)
		case Note.Alteration.natural, Note.Alteration.none:
			return Note(self.name, alt: Note.Alteration.flat, octave: self.octave)
		case Note.Alteration.sharp:
			return Note(self.name, alt: Note.Alteration.none, octave: self.octave)
		}
	}

	public var augmentedByOneSemitone: Note {
		switch self.alteration {
		case Note.Alteration.flat:
			return Note(self.name, alt: Note.Alteration.none, octave: self.octave)
		case Note.Alteration.natural, Note.Alteration.none:
			return Note(self.name, alt: Note.Alteration.sharp, octave: self.octave)
		case Note.Alteration.sharp:
			return Note(self.name.next, alt: Note.Alteration.none, octave: self.octave)
		}
	}
}

extension Note {
	public func augmenting(withStep step: Step) -> Note {
		let start = Int(0)
		var index = start
		let iterator = AnyIterator<Int> { () -> Int? in
			guard index < step.value else { return nil }
			index += 1
			return index
		}
		return iterator.map { $0 }.reduce(self, { (previousNote, step) -> Note in
			previousNote.augmentedByOneSemitone
		})
	}

	public func lowering(withStep step: Step) -> Note {
		let start = Int(step.value)
		var index = start
		let iterator = AnyIterator<Int> { () -> Int? in
			guard index >= 0 else { return nil }
			index -= 1
			return index
		}
		return iterator.map { $0 }.reduce(self, { (previousNote, step) -> Note in
			previousNote.loweringByOneSemitone
		})
	}
}

extension Note {
	public func interval(withNote note: Note) -> Interval {
		return Interval(self, note)
	}
}


extension Note {
	public var diatonic: Note {
		switch self.alteration {
		case Note.Alteration.flat:
			return Note(self.name.previous, alt: Note.Alteration.sharp, octave: self.octave)

		case Note.Alteration.natural, Note.Alteration.none:
			return self

		case Note.Alteration.sharp:
			return Note(self.name.next, alt: Note.Alteration.flat, octave: self.octave)
		}
	}
}

extension Note: CustomPlaygroundQuickLookable {
	public var customPlaygroundQuickLook: PlaygroundQuickLook {
		return PlaygroundQuickLook.text(self.description)
	}
}

extension Note: CustomStringConvertible {
	public var description: String {
		return "\(self.name)\(self.octave.identifier)\(self.alteration)"
	}
}

extension Note: Equatable {
	public static func == (lhs: Note, rhs: Note) -> Bool {
		return (lhs.hashValue == rhs.hashValue) ||
			(lhs.diatonic.hashValue == rhs.hashValue)
	}
}

extension Note: Hashable {
	public var hashValue: Int {
		return self.description.hashValue
	}
}
