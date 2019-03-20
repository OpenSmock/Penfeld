Class {
	#name : #CssPercentValue,
	#superclass : #CssValue,
	#category : #'CSS-Value'
}

{ #category : #'as yet unclassified' }
CssPercentValue >> computeValueFrom: aTargetNode property: aSymbol [
	aTargetNode owner
		ifNotNil: [ :p | 
			| pValue |
			pValue := p height max: p width.
			^ pValue * self value ].
	Error signal: 'a styleable parent must exist in order to apply a relative size '
]
