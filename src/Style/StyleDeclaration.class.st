Class {
	#name : #StyleDeclaration,
	#superclass : #Object,
	#instVars : [
		'property',
		'important',
		'rule'
	],
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleDeclaration >> = aDeclaration [
	^ self property = aDeclaration property
]

{ #category : #'adding/removing' }
StyleDeclaration >> addTo: aRule [
	self subclassResponsibility 
]

{ #category : #accessing }
StyleDeclaration >> important [
	^ important
]

{ #category : #accessing }
StyleDeclaration >> important: anObject [
	important := anObject
]

{ #category : #'initialize-release' }
StyleDeclaration >> initialize [
	super initialize.
	important := false
]

{ #category : #testing }
StyleDeclaration >> isImportant [
	^ important
]

{ #category : #accessing }
StyleDeclaration >> property [
	^ property
]

{ #category : #accessing }
StyleDeclaration >> property: anObject [
	property := anObject
]

{ #category : #accessing }
StyleDeclaration >> rule [
	^ rule
]

{ #category : #accessing }
StyleDeclaration >> rule: anObject [
	rule := anObject
]
