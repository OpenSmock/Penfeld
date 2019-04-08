Class {
	#name : #StyleMedia,
	#superclass : #Object,
	#instVars : [
		'conditions',
		'rules',
		'stylesheet'
	],
	#category : #'Style-Core'
}

{ #category : #'adding/removing' }
StyleMedia >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet medias add: self
]

{ #category : #'as yet unclassified' }
StyleMedia >> computedStyles [
	
]

{ #category : #accessing }
StyleMedia >> conditions [
	^ conditions
]

{ #category : #accessing }
StyleMedia >> conditions: aCollection [
	aCollection
		do: [ :item | 
			item media: self.
			self conditions add: item ]
]

{ #category : #'initialize-release' }
StyleMedia >> initialize [
	super initialize.
	conditions := OrderedCollection new.
	rules := OrderedCollection new
]

{ #category : #accessing }
StyleMedia >> rules [
	^ rules
]

{ #category : #accessing }
StyleMedia >> rules: anObject [
	rules := anObject
]

{ #category : #accessing }
StyleMedia >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
StyleMedia >> stylesheet: anObject [
	stylesheet := anObject
]
