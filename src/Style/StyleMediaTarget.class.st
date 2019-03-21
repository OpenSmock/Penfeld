Class {
	#name : #StyleMediaTarget,
	#superclass : #Object,
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleMediaTarget class >> defaultOn: aTarget [
	^ aTarget
]

{ #category : #'as yet unclassified' }
StyleMediaTarget class >> screenOn: aTarget [
	^ aTarget space root
]
