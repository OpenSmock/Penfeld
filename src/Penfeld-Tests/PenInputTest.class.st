Class {
	#name : #PenInputTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Elements'
}

{ #category : #tests }
PenInputTest >> testText [
	| input |
	input := PenInput new.
	
	"text must be empty"
	self assert: input text equals: ''.
	
	input text: 'Penfeld'.
	self assert: input text equals: 'Penfeld'.
]

{ #category : #tests }
PenInputTest >> testValueChangedEvent [
	| input counter |
	input := PenInput new.
	counter := 0.
	
	input onValueChangedDo: [ counter := counter + 1 ].
	self assert: counter equals: 0.
	
	input text: 'Penfeld'.
	Processor yield.
	self assert: counter equals: 1.
	
	input text: 'Penfeld'.
	Processor yield.
	self assert: counter equals: 1.
	
	input text: ''.
	Processor yield.
	self assert: counter equals: 2.
	
]
