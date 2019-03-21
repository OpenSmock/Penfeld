Class {
	#name : #StyleValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'transition',
		'animation'
	],
	#category : #'Style-Value'
}

{ #category : #'as yet unclassified' }
StyleValue class >> em: aValue [
	^ StyleEmValue value: aValue 
]

{ #category : #'as yet unclassified' }
StyleValue class >> ms: aValue [
	^ StyleDurationValue value: aValue
]

{ #category : #'as yet unclassified' }
StyleValue class >> percent: aValue [
	^ StylePercentValue value: aValue percent
]

{ #category : #'as yet unclassified' }
StyleValue class >> pt: aValue [
	^ StylePtValue value: aValue 
]

{ #category : #'as yet unclassified' }
StyleValue class >> px: aValue [
	^ StylePixelValue value: aValue
]

{ #category : #'as yet unclassified' }
StyleValue class >> rem: aValue [
	^ StyleRemValue value: aValue rem
]

{ #category : #'as yet unclassified' }
StyleValue class >> s: aValue [
	^ StyleDurationValue value: aValue s
]

{ #category : #'as yet unclassified' }
StyleValue class >> value: aValue [
	^ self value: aValue transition: nil
]

{ #category : #'as yet unclassified' }
StyleValue class >> value: aValue transition: aTransition [
	^ self new
		value: aValue;
		transition: aTransition;
		yourself
]

{ #category : #'as yet unclassified' }
StyleValue >> + anObject [
	^ self value + anObject
]

{ #category : #'as yet unclassified' }
StyleValue >> = aStyleValue [
	^ self value = aStyleValue value
]

{ #category : #'as yet unclassified' }
StyleValue >> @ anObject [
	^ self value @ anObject
]

{ #category : #accessing }
StyleValue >> animation [
	^ animation
]

{ #category : #accessing }
StyleValue >> animation: anObject [
	animation := anObject
]

{ #category : #'as yet unclassified' }
StyleValue >> asBlStyleValue [
	^ self
]

{ #category : #accessing }
StyleValue >> computeValueFrom: aTarget property: aSymbol [
	^ self 
]

{ #category : #'as yet unclassified' }
StyleValue >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self value
]

{ #category : #'as yet unclassified' }
StyleValue >> hasTransition [
	^ self transition isNotNil and: [ self transition duration > 0 ]
]

{ #category : #accessing }
StyleValue >> initialize [
	super initialize.

]

{ #category : #testing }
StyleValue >> isFunction [
	^ false
]

{ #category : #accessing }
StyleValue >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
StyleValue >> property: aSymbol of: aTarget [
	^ aTarget styler perform: aSymbol
]

{ #category : #accessing }
StyleValue >> transition [
	^ transition
]

{ #category : #accessing }
StyleValue >> transition: anObject [
	transition := anObject
]

{ #category : #accessing }
StyleValue >> value [
	^ value
]

{ #category : #accessing }
StyleValue >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
StyleValue >> valueRelativeTo: aTargetProperty [
	^ self value
]
