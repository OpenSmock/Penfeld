"
A PenContainerTest is a test class for testing the behavior of PenContainer
"
Class {
	#name : #PenContainerTest,
	#superclass : #TestCase,
	#instVars : [
		'container'
	],
	#category : #'Penfeld-Tests-Components'
}

{ #category : #running }
PenContainerTest >> setUp [ 
	container := PenContainer new addAllElements: { 
		PenContainer new 
			key: #container;
			addAllElements: { 
				(PenButton key: #key) text: 'Button2'.
				(PenButton key: #key2) text: 'Button3'.
				PenButton new text: 'Button4'
			}.	
		(PenButton key: #key) text: 'Button1'
	}
]

{ #category : #tests }
PenContainerTest >> testAddElement [
	| element |
	element := (PenButton key: #added).
	self assert: container elements size equals: 2.
	
	container addElement: element.
	self assert: container elements size equals: 3.
	self assert: (container getElement: #added) notNil
]

{ #category : #tests }
PenContainerTest >> testAllElements [
	| elements |
	elements := container allElements.
	self assert: elements size equals: 5.
	self assert: elements first key equals: #container.
	self assert: elements second text equals: 'Button1'.
	self assert: elements third text equals: 'Button2'.
	self assert: elements fourth text equals: 'Button3'.
	self assert: elements fifth text equals: 'Button4'.
]

{ #category : #tests }
PenContainerTest >> testGetElement [
	| element |
	element := container getElement: #key.
	self assert: element text equals: 'Button1'.
	
	element := container getElement: #key2.
	self assert: element text equals: 'Button3'.
]

{ #category : #tests }
PenContainerTest >> testRemoveElement [
	| element |
	element := (PenButton key: #added).
	container addElement: element.
	self assert: container elements size equals: 3.
	self assert: (container getElement: #added) notNil.
	
	container removeElement: element.
	self assert: container elements size equals: 2.
	self assert: (container getElement: #added) isNil.
]
