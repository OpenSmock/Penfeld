Class {
	#name : #StyleMatchedRule,
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
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StyleMatchedRule >> computedStyles [
	^ self declarations
		collect: [ :d | 
			CSSStyle new
				selector: self selector;
				declaration: d;
				conditions: self conditions;
				yourself ]
]

{ #category : #'as yet unclassified' }
StyleMatchedRule >> computedTransitions [
	^ self transitions
		collect: [ :t | CSSTransition new
				selector: self selector;
				transition: t;
				yourself ]
]

{ #category : #accessing }
StyleMatchedRule >> conditions [
	^ conditions
]

{ #category : #accessing }
StyleMatchedRule >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
StyleMatchedRule >> declarations [
	^ declarations
]

{ #category : #accessing }
StyleMatchedRule >> declarations: anObject [
	declarations := anObject
]

{ #category : #accessing }
StyleMatchedRule >> selector [
	^ selector
]

{ #category : #accessing }
StyleMatchedRule >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
StyleMatchedRule >> specificity [
	^ selector specificity
]

{ #category : #accessing }
StyleMatchedRule >> transitions [
	^ transitions
]

{ #category : #accessing }
StyleMatchedRule >> transitions: anObject [
	transitions := anObject
]
