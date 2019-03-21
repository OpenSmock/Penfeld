Class {
	#name : #PenSubMenu,
	#superclass : #PenButton,
	#instVars : [
		'menu'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #building }
PenSubMenu >> build [
	self menu ifNotNil: [ self build ].
	super build
]

{ #category : #accessing }
PenSubMenu >> menu [
	^ menu
]

{ #category : #accessing }
PenSubMenu >> menu: anObject [
	menu := anObject
]

{ #category : #performing }
PenSubMenu >> openMenu [
]

{ #category : #performing }
PenSubMenu >> perform [
	menu ifNotNil: [ self openMenu ]
]

{ #category : #accessing }
PenSubMenu >> styleName [
	^ #subMenu
]
