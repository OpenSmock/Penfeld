Class {
	#name : #PenEventBinding,
	#superclass : #Object,
	#instVars : [
		'callback',
		'autoBound'
	],
	#category : #'Penfeld-Events'
}

{ #category : #'instance creation' }
PenEventBinding class >> for: aSymbol do: aBlock [
	^ PenSimpleEventBinding new
		symbol: aSymbol;
		callback: aBlock;
		yourself
]

{ #category : #'instance creation' }
PenEventBinding class >> forAll: aList do: aBlock [
	^ PenCompositeEventBinding new
		symbols: aList;
		callback: aBlock;
		yourself
]

{ #category : #accessing }
PenEventBinding >> autoBind [
	autoBound := true
]

{ #category : #accessing }
PenEventBinding >> callback [
	^ callback
]

{ #category : #accessing }
PenEventBinding >> callback: aBlock [
	callback := aBlock
]

{ #category : #initialization }
PenEventBinding >> initialize [
	super initialize.
	autoBound := false
]

{ #category : #accessing }
PenEventBinding >> isAutoBound [
	^ autoBound
]

{ #category : #testing }
PenEventBinding >> isCompositeEvent [
	^ false
]

{ #category : #testing }
PenEventBinding >> isSimpleEvent [
	^ false
]
