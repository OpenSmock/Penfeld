Class {
	#name : #PenWindowBuilder,
	#superclass : #Object,
	#instVars : [
		'fullscreen'
	],
	#category : #'Penfeld-Abstracts'
}

{ #category : #accessing }
PenWindowBuilder class >> engine [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PenWindowBuilder class >> forEngine: anEngine [
	^ self allSubclasses 
		detect: [ :c | c engine = anEngine ]
		ifNone: [ nil ].
]

{ #category : #building }
PenWindowBuilder >> borderless: aBoolean [
	^ self subclassResponsibility
]

{ #category : #building }
PenWindowBuilder >> buildWindow: aWindow [
	^ self subclassResponsibility 
]

{ #category : #building }
PenWindowBuilder >> fullscreen [
	^ fullscreen ifNil: [ fullscreen := false ]
]

{ #category : #building }
PenWindowBuilder >> fullscreen: aBoolean [
	fullscreen := aBoolean
]

{ #category : #closing }
PenWindowBuilder >> onClosing: handle do: aBlock [
	^self subclassResponsibility 
]

{ #category : #closing }
PenWindowBuilder >> onLastClose: handle do: aBlock [
	^ self subclassResponsibility
]

{ #category : #building }
PenWindowBuilder >> updateViewDock: aDock [
	^ self subclassResponsibility  
]
