Class {
	#name : #PenWindowHelper,
	#superclass : #Object,
	#category : #'Penfeld-Abstracts'
}

{ #category : #accessing }
PenWindowHelper class >> engine [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PenWindowHelper class >> forEngine: anEngine [
	^ self allSubclasses 
		detect: [ :c | c engine = anEngine ]
		ifNone: [ nil ].
]

{ #category : #building }
PenWindowHelper >> buildWindow: aWindow [
	^ self subclassResponsibility 
]
