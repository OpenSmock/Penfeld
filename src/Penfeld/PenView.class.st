Class {
	#name : #PenView,
	#superclass : #PenComponent,
	#instVars : [
		'displayComponent'
	],
	#category : #'Penfeld-Components'
}

{ #category : #'instance creation' }
PenView class >> with: anElement [
	^ (self key: #view) 
		displayComponent: anElement;
		yourself
]

{ #category : #accessing }
PenView >> displayComponent [
	^ displayComponent
]

{ #category : #accessing }
PenView >> displayComponent: anObject [
	displayComponent := anObject.
	anObject ifNotNil:[ :d | d addStyleClass: #root].
	
]

{ #category : #accessing }
PenView >> dock [
	^ dock
]

{ #category : #accessing }
PenView >> dock: anObject [
	dock := anObject
]

{ #category : #testing }
PenView >> hasComponent [
	^ self displayComponent notNil
]

{ #category : #accessing }
PenView >> hide [
	self hasComponent ifFalse: [ ^ self ].
	self displayComponent hide.
]

{ #category : #testing }
PenView >> isBuilt [
	"return true when the view have no display component or return the build state of the display component"
	self hasComponent ifFalse: [ ^ true ].
	^ self displayComponent isBuilt
]

{ #category : #opening }
PenView >> openInMorphic [
	dock ifNil: [ dock := PenViewDock with: self ].
	dock openInMorphic.
]

{ #category : #opening }
PenView >> openInMorphicWindow [
	^PenWindow openInMorphicWindow: self
]

{ #category : #opening }
PenView >> openInWindow [
	^PenWindow openInWindow: self
]

{ #category : #opening }
PenView >> openInWorld [
	^PenWindow openInWorld: self
]

{ #category : #accessing }
PenView >> refresh [
	self hasComponent ifFalse: [ ^ self ].
	self displayComponent loopRefresh.
]

{ #category : #accessing }
PenView >> show [
	self hasComponent ifFalse: [ ^ self ].
	self displayComponent show.
]
