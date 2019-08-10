Class {
	#name : #PenWindowBuilder,
	#superclass : #Object,
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
PenWindowBuilder >> updateViewDock: aDock [
	^ self subclassResponsibility  
]
