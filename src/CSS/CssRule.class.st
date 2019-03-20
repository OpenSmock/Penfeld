Class {
	#name : #CssRule,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'declarations',
		'stylesheet',
		'transitions'
	],
	#category : #'CSS-Core'
}

{ #category : #'adding/removing' }
CssRule >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet rules add: self
]

{ #category : #accessing }
CssRule >> declarations [
	^ declarations
]

{ #category : #accessing }
CssRule >> declarations: aDeclarationList [
	aDeclarationList
		do: [ :d | 
			d rule: self.
			d addTo: self ]
]

{ #category : #'as yet unclassified' }
CssRule >> declare: anAssoc [
	self declare: anAssoc important: false
]

{ #category : #'as yet unclassified' }
CssRule >> declare: anAssoc important: aBoolean [
	self declarations
		add:
			(CSSPropertyDeclaration new
				property: anAssoc key;
				value: anAssoc value asBlStyleValue;
				rule: self;
				important: aBoolean;
				yourself)
]

{ #category : #'as yet unclassified' }
CssRule >> declareTransition: anAssoc [
	self transitions
		add:
			(CSSTransitionDeclaration new
				property: anAssoc key;
				valuesFromArray: anAssoc value;
				rule: self;
				yourself)
]

{ #category : #'initialize-release' }
CssRule >> initialize [
	super initialize.
	selectors := SortedCollection sortBlock: [ :s1 :s2 | s1 specificity >= s2 specificity ].
	declarations := OrderedCollection new.
	transitions := OrderedCollection new
]

{ #category : #accessing }
CssRule >> origin [
	^ stylesheet origin
]

{ #category : #accessing }
CssRule >> selectors [
	^ selectors
]

{ #category : #accessing }
CssRule >> selectors: anObject [
	selectors := anObject.
	selectors do: [ :s | s rule: self ]
]

{ #category : #accessing }
CssRule >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
CssRule >> stylesheet: anObject [
	stylesheet := anObject
]

{ #category : #accessing }
CssRule >> transitions [
	^ transitions
]

{ #category : #accessing }
CssRule >> transitions: aTransitionList [
	aTransitionList
		do: [ :d | 
			d rule: self.
			d addTo: self ]
]
