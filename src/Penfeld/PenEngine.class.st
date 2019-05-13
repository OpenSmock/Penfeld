Class {
	#name : #PenEngine,
	#superclass : #Object,
	#classVars : [
		'Default'
	],
	#category : #'Penfeld-Abstracts'
}

{ #category : #accessing }
PenEngine class >> default [
	Default ifNil: 
	[
		self 
			assert: self subclasses isEmpty not
			description: 'There is no engine to build Penfeld application.'.
			
		Default := self subclasses first new
	].
	^ Default
]

{ #category : #accessing }
PenEngine >> dressersMap [
	^ self subclassResponsibility
]

{ #category : #accessing }
PenEngine >> name [
	^ self subclassResponsibility 
]
