//: Playground - noun: a place where people can play

import UIKit

func notes() {
	//let m2 = Interval.Kind.m2
	//m2.steps

	let octave = Octave(identifier: 3)
	//octave.notes
	//
	//let b3 = Note(Note.Name.B, octave: octave)
	//
	//octave.contains(b3)

	let d3f = Note(Note.Name.D, alt: Note.Alteration.flat, octave: octave)
	//d3f.augmenting(withStep: AnyStep(step: 3))
	//
	//octave.contains(d3f)
	//
	//let i = Interval(b3, d3f)
	//
	let d3  = d3f.augmentedByOneSemitone
	let d3s = d3.augmentedByOneSemitone
	let e3  = d3s.augmentedByOneSemitone

	e3.loweringByOneSemitone.loweringByOneSemitone == d3
	d3s == e3.loweringByOneSemitone

	///////////////////////////////////////
	/// Note.Name Distance
	///////////////////////////////////////
	let noteA = d3s
	let noteB = e3
	let steps = noteA.name.steps(to: noteB.name)
	steps
	noteA.alteration
	noteA.alteration.alter(step: steps)
	noteB.alteration
	noteB.alteration.alter(step: steps)
	steps

	let a = Note.Name.G
	let b = Note.Name.E
	a.steps(to: b)
	a.distance(to: b)


	///////////////////////////////////////
	/// Interval
	///////////////////////////////////////

	let interval1 = d3s.interval(withNote: e3)
	interval1.kinds
	interval1.kind

	let interval2 = d3.interval(withNote: e3)
	interval2.kinds
	interval2.kind

	Note(a).interval(withNote: Note(b)).kind

	Note(Note.Name.F).interval(withNote: Note(Note.Name.B)).kind
	///////////////////////////////////////
	/// Alterations
	///////////////////////////////////////
	//let sharp = Note.Alteration.sharp
	//noteA
	//sharp.alter(note: noteA)
	//noteB
	//sharp.alter(note: noteB)
	//
	//let flat = Note.Alteration.flat
	//noteA
	//flat.alter(note: noteA)
	//noteB
	//flat.alter(note: noteB)
	//
	//let natural = Note.Alteration.natural
	//noteA
	//natural.alter(note: noteA)
	//noteB
	//natural.alter(note: noteB)


	///////////////////////////////////////
	/// Pair hash
	///////////////////////////////////////
	//let p = Pair<Note>(a: d3, b: e3)
	//p.hashValue
	//
	//let p2 = Pair<Note>(a: d3, b: d3f.augmenting(withStep: AnyStep(step: 3)))
	//p2.hashValue
	//
	//p == p2

	//let ab = Pair<Note.Name>(a: Note.Name.A, b: Note.Name.B)
	//ab.hashValue
	//
	//let bc = Pair<Note.Name>(a: Note.Name.B, b: Note.Name.C)
	//bc.hashValue
}

func keyboard() {
	let kv = KeyView()
}

keyboard()

