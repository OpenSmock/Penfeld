Class {
	#name : #PenDefaultStylesheetTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Utils'
}

{ #category : #tests }
PenDefaultStylesheetTest >> testLight [
	| stylesheet |
	stylesheet := PenDefaultStylesheet light.
	self assert: stylesheet class equals: PssStylesheet. 
]
