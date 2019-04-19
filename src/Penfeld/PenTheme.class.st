"
Set of dressers + one or several stylesheets
"
Class {
	#name : #PenTheme,
	#superclass : #Object,
	#instVars : [
		'style',
		'dressersMap'
	],
	#category : #'Penfeld-Core'
}

{ #category : #'as yet unclassified' }
PenTheme >> dresserFor: aModel [
	^ dressersMap at: aModel
]

{ #category : #initialization }
PenTheme >> initDressersMap [
	self subclassResponsibility 
]

{ #category : #initialization }
PenTheme >> initialize [
	super initialize.
	self initDressersMap
]
