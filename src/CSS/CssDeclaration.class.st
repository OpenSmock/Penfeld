Class {
	#name : #CssDeclaration,
	#superclass : #Object,
	#instVars : [
		'property',
		'important',
		'rule'
	],
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssDeclaration >> = aDeclaration [
	^ self property = aDeclaration property
]

{ #category : #'adding/removing' }
CssDeclaration >> addTo: aRule [
	self subclassResponsibility 
]

{ #category : #accessing }
CssDeclaration >> important [
	^ important
]

{ #category : #accessing }
CssDeclaration >> important: anObject [
	important := anObject
]

{ #category : #'initialize-release' }
CssDeclaration >> initialize [
	super initialize.
	important := false
]

{ #category : #testing }
CssDeclaration >> isImportant [
	^ important
]

{ #category : #accessing }
CssDeclaration >> property [
	^ property
]

{ #category : #accessing }
CssDeclaration >> property: anObject [
	property := anObject
]

{ #category : #accessing }
CssDeclaration >> rule [
	^ rule
]

{ #category : #accessing }
CssDeclaration >> rule: anObject [
	rule := anObject
]
