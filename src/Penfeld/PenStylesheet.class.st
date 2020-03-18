Class {
	#name : #PenStylesheet,
	#superclass : #Object,
	#category : #'Penfeld-Utils'
}

{ #category : #parsing }
PenStylesheet class >> parse: aString [
	^ PssSimpleParser parse: aString
]

{ #category : #parsing }
PenStylesheet class >> parseString: aString [
	^ self parserClass parse: aString
]

{ #category : #parsing }
PenStylesheet class >> parserClass [ 
	^ PssModelParser
]
