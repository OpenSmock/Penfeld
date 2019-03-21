Class {
	#name : #StylePropertyDeclaration,
	#superclass : #StyleDeclaration,
	#instVars : [
		'value'
	],
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StylePropertyDeclaration >> = aDeclaration [
	^ super = aDeclaration and: [ self value = aDeclaration value ]
]

{ #category : #'adding/removing' }
StylePropertyDeclaration >> addTo: aRule [
	aRule declarations add: self
]

{ #category : #printing }
StylePropertyDeclaration >> printOn: aStream [
	aStream
		nextPutAll: self property;
		nextPutAll: ': ';
		nextPutAll: self value asString.
	self isImportant
		ifTrue: [ aStream nextPutAll: '!important' ]
]

{ #category : #accessing }
StylePropertyDeclaration >> value [
	^ value
]

{ #category : #accessing }
StylePropertyDeclaration >> value: anObject [
	value := anObject
]
