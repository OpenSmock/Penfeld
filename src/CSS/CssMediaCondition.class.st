Class {
	#name : #CssMediaCondition,
	#superclass : #Object,
	#instVars : [
		'type',
		'conditions',
		'media'
	],
	#category : #'CSS-Core'
}

{ #category : #accessing }
CssMediaCondition >> conditions [
	^ conditions
]

{ #category : #accessing }
CssMediaCondition >> conditions: anObject [
	conditions := anObject
]

{ #category : #'evaluating conditions' }
CssMediaCondition >> heightOf: aTarget value: aValue [
	^ aTarget height = aValue
]

{ #category : #testing }
CssMediaCondition >> isValidOn: aTarget [
	| typeTarget |
	typeTarget := CSSMediaTarget
		perform: (self type , 'On:') asSymbol
		with: aTarget.
	conditions
		keysAndValuesDo:
			[ :k :v | 
			(self
				perform: (k , 'Of:' , 'value:') asSymbol
				withEnoughArguments:
					{typeTarget.
					v value})
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'evaluating conditions' }
CssMediaCondition >> maxHeightOf: aTarget value: aValue [
	^ aTarget height <= aValue
]

{ #category : #'evaluating conditions' }
CssMediaCondition >> maxWidthOf: aTarget value: aValue [
	^ aTarget width <= aValue
]

{ #category : #accessing }
CssMediaCondition >> media [
	^ media
]

{ #category : #accessing }
CssMediaCondition >> media: anObject [
	media := anObject
]

{ #category : #'evaluating conditions' }
CssMediaCondition >> minHeightOf: aTarget value: aValue [
	^ aTarget height >= aValue
]

{ #category : #'evaluating conditions' }
CssMediaCondition >> minWidthOf: aTarget value: aValue [
	^ aTarget width >= aValue
]

{ #category : #accessing }
CssMediaCondition >> type [
	^ type
]

{ #category : #accessing }
CssMediaCondition >> type: anObject [
	type := anObject
]

{ #category : #'evaluating conditions' }
CssMediaCondition >> widthOf: aTarget value: aValue [
	^ aTarget width = aValue
]
