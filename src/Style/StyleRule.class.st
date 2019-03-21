Class {
	#name : #StyleRule,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'declarations',
		'stylesheet',
		'transitions'
	],
	#category : #'Style-Core'
}

{ #category : #'adding/removing' }
StyleRule >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet rules add: self
]

{ #category : #accessing }
StyleRule >> declarations [
	^ declarations
]

{ #category : #accessing }
StyleRule >> declarations: aDeclarationList [
	aDeclarationList
		do: [ :d | 
			d rule: self.
			d addTo: self ]
]

{ #category : #'as yet unclassified' }
StyleRule >> declare: anAssoc [
	self declare: anAssoc important: false
]

{ #category : #'as yet unclassified' }
StyleRule >> declare: anAssoc important: aBoolean [
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
StyleRule >> declareTransition: anAssoc [
	self transitions
		add:
			(CSSTransitionDeclaration new
				property: anAssoc key;
				valuesFromArray: anAssoc value;
				rule: self;
				yourself)
]

{ #category : #'initialize-release' }
StyleRule >> initialize [
	super initialize.
	selectors := SortedCollection sortBlock: [ :s1 :s2 | s1 specificity >= s2 specificity ].
	declarations := OrderedCollection new.
	transitions := OrderedCollection new
]

{ #category : #accessing }
StyleRule >> origin [
	^ stylesheet origin
]

{ #category : #accessing }
StyleRule >> selectors [
	^ selectors
]

{ #category : #accessing }
StyleRule >> selectors: anObject [
	selectors := anObject.
	selectors do: [ :s | s rule: self ]
]

{ #category : #accessing }
StyleRule >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
StyleRule >> stylesheet: anObject [
	stylesheet := anObject
]

{ #category : #accessing }
StyleRule >> transitions [
	^ transitions
]

{ #category : #accessing }
StyleRule >> transitions: aTransitionList [
	aTransitionList
		do: [ :d | 
			d rule: self.
			d addTo: self ]
]
