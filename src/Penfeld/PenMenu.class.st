Class {
	#name : #PenMenu,
	#superclass : #PenInteractionElement,
	#instVars : [
		'subMenus'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenMenu class >> styleName [
	^ #menu
]

{ #category : #adding }
PenMenu >> add: aSubMenu [
	aSubMenu parent: self.
	subMenus add: aSubMenu
]

{ #category : #adding }
PenMenu >> addAll: aList [
	aList do: [ :each |
		self add: each ]
]

{ #category : #building }
PenMenu >> build [
	self subMenus do: [ :each |
		each build ].
	super build
]

{ #category : #initialization }
PenMenu >> initialize [
	super initialize.
	subMenus := OrderedCollection new.
]

{ #category : #accessing }
PenMenu >> subMenus [
	^ subMenus
]
