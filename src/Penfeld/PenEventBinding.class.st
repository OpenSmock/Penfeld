Class {
	#name : #PenEventBinding,
	#superclass : #Object,
	#instVars : [
		'callback',
		'autoInstall'
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
	^ PFCompositeEventBinding new
		symbols: aList;
		callback: aBlock;
		yourself
]

{ #category : #accessing }
PenEventBinding >> autoInstall [
	autoInstall := true
]

{ #category : #accessing }
PenEventBinding >> autoInstalled [
	^ autoInstall
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
	autoInstall := false
]

{ #category : #testing }
PenEventBinding >> isCompositeEvent [
	^ false
]

{ #category : #testing }
PenEventBinding >> isInstalled [
	^ autoInstall 
]

{ #category : #testing }
PenEventBinding >> isSimpleEvent [
	^ false
]
