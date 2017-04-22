//
//  Interval.swift
//  Muserval
//
//  Created by Georges Boumis on 15/10/2016.
//  Copyright © 2016 Georges Boumis. All rights reserved.
//

import Foundation

public struct Interval {
	public enum Kind: String, CustomStringConvertible {
		//   name;        descirption;       semitones
		case P1 = "P1" // perfect unison     0
		case m2 = "2m" // minor second       1
		case M2 = "2M" // Major second       2
		case m3 = "m3" // minor third        3
		case M3 = "3M" // Major third        4
		case P4 = "P4" // perfect fourth     5
		case P5 = "P5" // perfect fifth      7
		case m6 = "m6" // minor sixth        8
		case M6 = "M6" // Major sixth        9
		case m7 = "m7" // minor seventh      10
		case M7 = "M7" // Major seventh      11
		case P8 = "P8" // Perfect octave     12

		case d2 = "d2" // diminished second  0
		case A1 = "A1" // augmented unison   1
		case d3 = "d3" // diminished third   2
		case A2 = "a2" // augmented second   3
		case d4 = "d4" // diminished fourth  4
		case A3 = "A3" // augmented third    5
		case d5 = "d5" // diminished fifth   6
		case A4 = "A4" // augmented fourth   6
		case d6 = "d6" // diminished sixth   7
		case A5 = "A5" // augmented fifth    8
		case d7 = "d7" // diminished seventh 9
		case A6 = "A6" // augmented sixth    10
		case d8 = "d8" // diminished octave  11
		case A7 = "A7" // augmented seventh  12

		case S = "S"   // semitone           1
		case T = "T"   // tone               2

		public var description: String {
			return self.rawValue
		}

		public struct Description: CustomStringConvertible {
			private let kind: Interval.Kind
			public init(kind: Interval.Kind) {
				self.kind = kind
			}
			public var description: String {
				switch self.kind {
				case Interval.Kind.P1: return "perfect unison"
				case Interval.Kind.m2: return "minor second"
				case Interval.Kind.M2: return "major second"
				case Interval.Kind.m3: return "minor third"
				case Interval.Kind.M3: return "major third"
				case Interval.Kind.P4: return "perfect fourth"
				case Interval.Kind.P5: return "perfect fifth"
				case Interval.Kind.m6: return "minor sixth"
				case Interval.Kind.M6: return "major sixth"
				case Interval.Kind.m7: return "minor seventh"
				case Interval.Kind.M7: return "major seventh"
				case Interval.Kind.P8: return "perfect octave"

				case Interval.Kind.d2: return "diminished second"
				case Interval.Kind.A1: return "augmented unison"
				case Interval.Kind.d3: return "diminished third"
				case Interval.Kind.A2: return "augmented second"
				case Interval.Kind.d4: return "diminished fourth"
				case Interval.Kind.A3: return "augmented third"
				case Interval.Kind.d5: return "diminished fifth"
				case Interval.Kind.A4: return "augmented fourth"
				case Interval.Kind.d6: return "diminished sixth"
				case Interval.Kind.A5: return "augmented fifth"
				case Interval.Kind.d7: return "diminished seventh"
				case Interval.Kind.A6: return "augmented sixth"
				case Interval.Kind.d8: return "diminished octave"
				case Interval.Kind.A7: return "augmented seventh"

				case Interval.Kind.S: return "semitone"
				case Interval.Kind.T: return "tone"
				}
			}
		}

		public var steps: Step {
			switch self {
			case Interval.Kind.P1: return AnyStep(step: 0)
			case Interval.Kind.m2: return Semitone()
			case Interval.Kind.M2: return Tone()
			case Interval.Kind.m3: return AnyStep(step: 3)
			case Interval.Kind.M3: return AnyStep(step: 4)
			case Interval.Kind.P4: return AnyStep(step: 5)
			case Interval.Kind.P5: return AnyStep(step: 7)
			case Interval.Kind.m6: return AnyStep(step: 8)
			case Interval.Kind.M6: return AnyStep(step: 9)
			case Interval.Kind.m7: return AnyStep(step: 10)
			case Interval.Kind.M7: return AnyStep(step: 11)
			case Interval.Kind.P8: return AnyStep(step: 12)

			case Interval.Kind.d2: return AnyStep(step: 0)
			case Interval.Kind.A1: return AnyStep(step: 1)
			case Interval.Kind.d3: return AnyStep(step: 2)
			case Interval.Kind.A2: return AnyStep(step: 3)
			case Interval.Kind.d4: return AnyStep(step: 4)
			case Interval.Kind.A3: return AnyStep(step: 5)
			case Interval.Kind.d5: return AnyStep(step: 6)
			case Interval.Kind.A4: return AnyStep(step: 6)
			case Interval.Kind.d6: return AnyStep(step: 7)
			case Interval.Kind.A5: return AnyStep(step: 8)
			case Interval.Kind.d7: return AnyStep(step: 9)
			case Interval.Kind.A6: return AnyStep(step: 10)
			case Interval.Kind.d8: return AnyStep(step: 11)
			case Interval.Kind.A7: return AnyStep(step: 12)

			case Interval.Kind.S: return Semitone()
			case Interval.Kind.T: return Tone()
			}
		}

		fileprivate static let stepMapping: [Int: Set<Interval.Kind>] = [
			Int(0)  : Set<Interval.Kind>([Interval.Kind.P1, Interval.Kind.d2] as [Interval.Kind]),
			Int(1)  : Set<Interval.Kind>([Interval.Kind.S, Interval.Kind.m2, Interval.Kind.A1] as [Interval.Kind]),
			Int(2)  : Set<Interval.Kind>([Interval.Kind.T, Interval.Kind.M2, Interval.Kind.d3] as [Interval.Kind]),
			Int(3)  : Set<Interval.Kind>([Interval.Kind.m3, Interval.Kind.A2] as [Interval.Kind]),
			Int(4)  : Set<Interval.Kind>([Interval.Kind.M3, Interval.Kind.d4] as [Interval.Kind]),
			Int(5)  : Set<Interval.Kind>([Interval.Kind.P4, Interval.Kind.A3] as [Interval.Kind]),
			Int(6)  : Set<Interval.Kind>([Interval.Kind.A4, Interval.Kind.d5] as [Interval.Kind]),
			Int(7)  : Set<Interval.Kind>([Interval.Kind.P5, Interval.Kind.d6] as [Interval.Kind]),
			Int(8)  : Set<Interval.Kind>([Interval.Kind.m6, Interval.Kind.A5] as [Interval.Kind]),
			Int(9)  : Set<Interval.Kind>([Interval.Kind.M6, Interval.Kind.d7] as [Interval.Kind]),
			Int(10) : Set<Interval.Kind>([Interval.Kind.m7, Interval.Kind.A6] as [Interval.Kind]),
			Int(11) : Set<Interval.Kind>([Interval.Kind.M7, Interval.Kind.d8] as [Interval.Kind]),
			Int(12) : Set<Interval.Kind>([Interval.Kind.P8, Interval.Kind.A7] as [Interval.Kind]),
		]

		typealias Distance = Int
		fileprivate static let _associations: [Distance: [Int: Interval.Kind]] = [
			Distance(0)  : [0: Interval.Kind.P1,
			                1: Interval.Kind.A1] as [Int: Interval.Kind],
			Distance(1)  : [0: Interval.Kind.d2,
			                1: Interval.Kind.m2,
			                2: Interval.Kind.M2,
			                3: Interval.Kind.A2] as [Int: Interval.Kind],
			Distance(2)  : [2: Interval.Kind.d3,
			                3: Interval.Kind.m3,
			                4: Interval.Kind.M3,
			                5: Interval.Kind.A3] as [Int: Interval.Kind],
			Distance(3)  : [4: Interval.Kind.d4,
			                5: Interval.Kind.P4,
			                6: Interval.Kind.A4] as [Int: Interval.Kind],
			Distance(4)  : [6: Interval.Kind.d5,
			                7: Interval.Kind.P5,
			                8: Interval.Kind.A5] as [Int: Interval.Kind],
			Distance(5)  : [7: Interval.Kind.d6,
			                8: Interval.Kind.m6,
			                9: Interval.Kind.M6,
			                10: Interval.Kind.A6] as [Int: Interval.Kind],
			Distance(6)  : [9: Interval.Kind.d7,
			                10: Interval.Kind.m7,
			                11: Interval.Kind.M7,
			                12: Interval.Kind.A7] as [Int: Interval.Kind],
			Distance(7)  : [11: Interval.Kind.d8,
			                12: Interval.Kind.P8]as [Int: Interval.Kind],
			]

		private init(_ v: Interval.Kind) {
			self.init(rawValue: v.rawValue)!
		}

		public init(step: Step, distance: Int) {
			self.init(Interval.Kind._associations[distance]![step.value]!)
		}
	}

	public let notes: Pair<Note>
	public var steps: Step {
		var step = Int(0)
		let noteA = self.notes.a
		let noteB = self.notes.b

		var tempNote = noteA

		while (noteB != tempNote) {
			tempNote = tempNote.augmentedByOneSemitone
			step += 1
		}
		return AnyStep.derive(step: step)
	}
	public var kinds: Set<Interval.Kind> {
		return Interval.Kind.stepMapping[self.steps.value]!
	}

	public var kind: Interval.Kind {
		let noteA = self.notes.a
		let noteB = self.notes.b

		let distance = noteA.name.distance(to: noteB.name)
		var step = noteA.name.steps(to: noteB.name)
		step = AnyStep.derive(step: step.value-noteA.alteration.step.value)
		step = noteB.alteration.alter(step: step)
		return Interval.Kind(step: step, distance: distance)
	}

	public init(withPair pair: Pair<Note>) {
		self.notes = pair
	}

	public init(_ noteA: Note, _ noteB: Note) {
		self.notes = Pair<Note>(a: noteA, b: noteB)
	}
}

extension Interval: CustomStringConvertible {
	public var description: String {
		let kindsDescriptions = self.kinds.map { Interval.Kind.Description(kind: $0) }
		return "\(self.notes.a)-\(self.notes.b) = \(self.kinds) (\(kindsDescriptions))"
	}
}

