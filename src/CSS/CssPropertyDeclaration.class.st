Class {
	#name : #CssPropertyDeclaration,
	#superclass : #CssDeclaration,
	#instVars : [
		'value'
	],
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssPropertyDeclaration >> = aDeclaration [
	^ super = aDeclaration and: [ self value = aDeclaration value ]
]

{ #category : #'adding/removing' }
CssPropertyDeclaration >> addTo: aRule [
	aRule declarations add: self
]

{ #category : #printing }
CssPropertyDeclaration >> printOn: aStream [
	aStream
		nextPutAll: self property;
		nextPutAll: ': ';
		nextPutAll: self value asString.
	self isImportant
		ifTrue: [ aStream nextPutAll: '!important' ]
]

{ #category : #accessing }
CssPropertyDeclaration >> value [
	^ value
]

{ #category : #accessing }
CssPropertyDeclaration >> value: anObject [
	value := anObject
]
