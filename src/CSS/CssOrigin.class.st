Class {
	#name : #CssOrigin,
	#superclass : #Object,
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssOrigin class >> AUTHOR [
	^ CSSAuthorOrigin
]

{ #category : #'as yet unclassified' }
CssOrigin class >> INLINE [
	^ CSSInlineOrigin
]

{ #category : #'as yet unclassified' }
CssOrigin class >> USER [
	^ CSSUserOrigin
]

{ #category : #'as yet unclassified' }
CssOrigin class >> USER_AGENT [
	^ CSSUserAgentOrigin
]
