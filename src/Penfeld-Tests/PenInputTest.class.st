Class {
	#name : #PenInputTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Elements'
}

{ #category : #tests }
PenInputTest >> testFormat [
	| input |
	
	input := PenInput new.
	input text: 'Penfeld'.
	self assert: input formatter isNil.
	
	input format.
	self assert: input text equals: 'Penfeld'.
	
	input formatter: PenFormatter new.
	self assert: input formatter notNil.
	input format.
	self assert: input text equals: 'Penfeld'.
]

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
PenInputTest >> testValidate [
	| input |
	
	input := PenInput new.
	input text: 'Penfeld'.
	self assert: input valider isNil.
	
	input validate.
	self assert: (input includesPseudoClass: #valid ) not.
	self assert: (input includesPseudoClass: #invalid ) not.
	
	input valider: PenValider new.
	self assert: input valider notNil.
	
	input validate.
	self assert: (input includesPseudoClass: #valid ).
	self assert: (input includesPseudoClass: #invalid ) not.
]

{ #category : #tests }
PenInputTest >> testValueChangedEvent [
	| input counter |
	input := PenInput new.
	counter := 0.
	
	input onValueChangedDo: [ counter := counter + 1 ].
	self assert: counter equals: 0.
	
	input text: 'Penfeld'.
	self assert: counter equals: 1.
	
	input text: 'Penfeld'.
	self assert: counter equals: 1.
	
	input text: ''.
	self assert: counter equals: 2.
	
]
