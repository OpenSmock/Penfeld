Class {
	#name : #StyleMediaCondition,
	#superclass : #Object,
	#instVars : [
		'type',
		'conditions',
		'media'
	],
	#category : #'Style-Core'
}

{ #category : #accessing }
StyleMediaCondition >> conditions [
	^ conditions
]

{ #category : #accessing }
StyleMediaCondition >> conditions: anObject [
	conditions := anObject
]

{ #category : #'evaluating conditions' }
StyleMediaCondition >> heightOf: aTarget value: aValue [
	^ aTarget height = aValue
]

{ #category : #testing }
StyleMediaCondition >> isValidOn: aTarget [
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
StyleMediaCondition >> maxHeightOf: aTarget value: aValue [
	^ aTarget height <= aValue
]

{ #category : #'evaluating conditions' }
StyleMediaCondition >> maxWidthOf: aTarget value: aValue [
	^ aTarget width <= aValue
]

{ #category : #accessing }
StyleMediaCondition >> media [
	^ media
]

{ #category : #accessing }
StyleMediaCondition >> media: anObject [
	media := anObject
]

{ #category : #'evaluating conditions' }
StyleMediaCondition >> minHeightOf: aTarget value: aValue [
	^ aTarget height >= aValue
]

{ #category : #'evaluating conditions' }
StyleMediaCondition >> minWidthOf: aTarget value: aValue [
	^ aTarget width >= aValue
]

{ #category : #accessing }
StyleMediaCondition >> type [
	^ type
]

{ #category : #accessing }
StyleMediaCondition >> type: anObject [
	type := anObject
]

{ #category : #'evaluating conditions' }
StyleMediaCondition >> widthOf: aTarget value: aValue [
	^ aTarget width = aValue
]
