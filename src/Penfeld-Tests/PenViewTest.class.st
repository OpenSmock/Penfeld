Class {
	#name : #PenViewTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Components'
}

{ #category : #tests }
PenViewTest >> testInitialization [ 
	| view |
	view := PenView new.
	"default values test"
	self assert: view key isNil.
	self assert: view hasComponent equals: false.
	self assert: view displayComponent isNil.
	self assert: view isBuilt equals: true.
	
	view show.
	view refresh.
	view hide.
]

{ #category : #tests }
PenViewTest >> testOpenInMorphicWindow [ 
	| view penWindow |
	view := PenView new.
	penWindow := view openInMorphicWindow.
	(Delay forMilliseconds: 500) wait.
	self assert: penWindow isOpened.
	penWindow close.
	self flag:'PLA : la fenetre ne se ferme pas'.
	self assert: penWindow isOpened equals: false.
]

{ #category : #tests }
PenViewTest >> testOpenInWindow [
	| view penWindow |
	view := PenView new.
	penWindow := view openInWindow.
	(Delay forMilliseconds: 500) wait.
	self assert: penWindow isOpened.
	penWindow close.
	self flag:'PLA : la fenetre ne se ferme pas'.
	self assert: penWindow isOpened equals: false.
]

{ #category : #tests }
PenViewTest >> testOpenInWorld [ 
	| view penWindow |
	view := PenView new.
	penWindow := view openInWorld.
	(Delay forMilliseconds: 500) wait.
	self assert: penWindow isOpened.
	penWindow close.
	self flag:'PLA : la fenetre ne se ferme pas'.
	self assert: penWindow isOpened equals: false.
]

{ #category : #tests }
PenViewTest >> testWithDisplayComponent [
	| view |
	view := PenView new.
	view displayComponent: PenContainer new.
	self assert: view key isNil.
	self assert: view hasComponent equals: true.
	self assert: view displayComponent notNil.
	self assert: view isBuilt equals: false.
	
	view show.
	view refresh.
	view hide.
]
