Class {
	#name : #CssMatchedRule,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declarations',
		'transitions',
		'conditions'
	],
	#classVars : [
		'AkStyleTransition'
	],
	#category : #'CSS-Utils'
}

{ #category : #'as yet unclassified' }
CssMatchedRule >> computedStyles [
	^ self declarations
		collect: [ :d | 
			CSSStyle new
				selector: self selector;
				declaration: d;
				conditions: self conditions;
				yourself ]
]

{ #category : #'as yet unclassified' }
CssMatchedRule >> computedTransitions [
	^ self transitions
		collect: [ :t | CSSTransition new
				selector: self selector;
				transition: t;
				yourself ]
]

{ #category : #accessing }
CssMatchedRule >> conditions [
	^ conditions
]

{ #category : #accessing }
CssMatchedRule >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
CssMatchedRule >> declarations [
	^ declarations
]

{ #category : #accessing }
CssMatchedRule >> declarations: anObject [
	declarations := anObject
]

{ #category : #accessing }
CssMatchedRule >> selector [
	^ selector
]

{ #category : #accessing }
CssMatchedRule >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
CssMatchedRule >> specificity [
	^ selector specificity
]

{ #category : #accessing }
CssMatchedRule >> transitions [
	^ transitions
]

{ #category : #accessing }
CssMatchedRule >> transitions: anObject [
	transitions := anObject
]
