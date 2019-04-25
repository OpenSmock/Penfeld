Class {
	#name : #PenSimpleEventBinding,
	#superclass : #PenEventBinding,
	#instVars : [
		'symbol'
	],
	#category : #'Penfeld-Events'
}

{ #category : #testing }
PenSimpleEventBinding >> isSimpleEvent [
	^ true
]

{ #category : #accessing }
PenSimpleEventBinding >> symbol [
	^ symbol
]

{ #category : #accessing }
PenSimpleEventBinding >> symbol: aSymbol [
	symbol := aSymbol
]

{ #category : #testing }
PenSimpleEventBinding >> symbolMatches: aSymbol [
	^ self symbol = aSymbol
]
