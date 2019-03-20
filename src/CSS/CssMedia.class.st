Class {
	#name : #CssMedia,
	#superclass : #Object,
	#instVars : [
		'conditions',
		'rules',
		'stylesheet'
	],
	#category : #'CSS-Core'
}

{ #category : #'adding/removing' }
CssMedia >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet medias add: self
]

{ #category : #'as yet unclassified' }
CssMedia >> computedStyles [
	
]

{ #category : #accessing }
CssMedia >> conditions [
	^ conditions
]

{ #category : #accessing }
CssMedia >> conditions: aCollection [
	aCollection
		do: [ :item | 
			item media: self.
			self conditions add: item ]
]

{ #category : #'initialize-release' }
CssMedia >> initialize [
	super initialize.
	conditions := OrderedCollection new.
	rules := OrderedCollection new
]

{ #category : #accessing }
CssMedia >> rules [
	^ rules
]

{ #category : #accessing }
CssMedia >> rules: anObject [
	rules := anObject
]

{ #category : #accessing }
CssMedia >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
CssMedia >> stylesheet: anObject [
	stylesheet := anObject
]
