Class {
	#name : #StyleOrigin,
	#superclass : #Object,
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleOrigin class >> AUTHOR [
	^ CSSAuthorOrigin
]

{ #category : #'as yet unclassified' }
StyleOrigin class >> INLINE [
	^ CSSInlineOrigin
]

{ #category : #'as yet unclassified' }
StyleOrigin class >> USER [
	^ CSSUserOrigin
]

{ #category : #'as yet unclassified' }
StyleOrigin class >> USER_AGENT [
	^ CSSUserAgentOrigin
]
