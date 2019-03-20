Class {
	#name : #CssValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'transition',
		'animation'
	],
	#category : #'CSS-Value'
}

{ #category : #'as yet unclassified' }
CssValue class >> em: aValue [
	^ CssEmValue value: aValue 
]

{ #category : #'as yet unclassified' }
CssValue class >> ms: aValue [
	^ CssDurationValue value: aValue
]

{ #category : #'as yet unclassified' }
CssValue class >> percent: aValue [
	^ CssPercentValue value: aValue percent
]

{ #category : #'as yet unclassified' }
CssValue class >> pt: aValue [
	^ CssPtValue value: aValue 
]

{ #category : #'as yet unclassified' }
CssValue class >> px: aValue [
	^ CssPixelValue value: aValue
]

{ #category : #'as yet unclassified' }
CssValue class >> rem: aValue [
	^ CssRemValue value: aValue rem
]

{ #category : #'as yet unclassified' }
CssValue class >> s: aValue [
	^ CssDurationValue value: aValue s
]

{ #category : #'as yet unclassified' }
CssValue class >> value: aValue [
	^ self value: aValue transition: nil
]

{ #category : #'as yet unclassified' }
CssValue class >> value: aValue transition: aTransition [
	^ self new
		value: aValue;
		transition: aTransition;
		yourself
]

{ #category : #'as yet unclassified' }
CssValue >> + anObject [
	^ self value + anObject
]

{ #category : #'as yet unclassified' }
CssValue >> = aStyleValue [
	^ self value = aStyleValue value
]

{ #category : #'as yet unclassified' }
CssValue >> @ anObject [
	^ self value @ anObject
]

{ #category : #accessing }
CssValue >> animation [
	^ animation
]

{ #category : #accessing }
CssValue >> animation: anObject [
	animation := anObject
]

{ #category : #'as yet unclassified' }
CssValue >> asBlStyleValue [
	^ self
]

{ #category : #accessing }
CssValue >> computeValueFrom: aTarget property: aSymbol [
	^ self 
]

{ #category : #'as yet unclassified' }
CssValue >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self value
]

{ #category : #'as yet unclassified' }
CssValue >> hasTransition [
	^ self transition isNotNil and: [ self transition duration > 0 ]
]

{ #category : #accessing }
CssValue >> initialize [
	super initialize.

]

{ #category : #testing }
CssValue >> isFunction [
	^ false
]

{ #category : #accessing }
CssValue >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
CssValue >> property: aSymbol of: aTarget [
	^ aTarget styler perform: aSymbol
]

{ #category : #accessing }
CssValue >> transition [
	^ transition
]

{ #category : #accessing }
CssValue >> transition: anObject [
	transition := anObject
]

{ #category : #accessing }
CssValue >> value [
	^ value
]

{ #category : #accessing }
CssValue >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
CssValue >> valueRelativeTo: aTargetProperty [
	^ self value
]
