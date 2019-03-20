Class {
	#name : #CssMediaTarget,
	#superclass : #Object,
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssMediaTarget class >> defaultOn: aTarget [
	^ aTarget
]

{ #category : #'as yet unclassified' }
CssMediaTarget class >> screenOn: aTarget [
	^ aTarget space root
]
