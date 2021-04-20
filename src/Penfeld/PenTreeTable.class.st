Class {
	#name : #PenTreeTable,
	#superclass : #PenTree,
	#traits : 'TPenSections',
	#classTraits : 'TPenSections classTrait',
	#instVars : [
		'treeSectionSelector',
		'sections',
		'sectionsSelectorSorted',
		'dragSections',
		'header',
		'showHeader'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenTreeTable class >> styleName [
	^ #treeTable
]

{ #category : #building }
PenTreeTable >> build [
	(self header isNotNil and: [self showHeader])
		ifTrue: [ self header build ].
	super build.
]

{ #category : #accessing }
PenTreeTable >> dragSections [
	^ dragSections
]

{ #category : #accessing }
PenTreeTable >> dragSections: anObject [
	dragSections := anObject
]

{ #category : #accessing }
PenTreeTable >> header [
	^ header
]

{ #category : #accessing }
PenTreeTable >> header: anObject [
	header := anObject.
	anObject parent: self
]

{ #category : #initialization }
PenTreeTable >> initialize [
	super initialize.
	sections := #().
	root := PenTreeTableNode new parent: self.
	showHeader := false.
	dragSections := false.
]

{ #category : #building }
PenTreeTable >> refresh [
	self root refresh.
	super refresh.
]

{ #category : #building }
PenTreeTable >> refreshSectionsOrder [
	self flag: #doItBetter.
	self header ifNotNil: [ self header dresser sectionsOrderChanged: self header ].
	self getExpandedNodesAsList do: [ :item | item dresser sectionsOrderChanged: item ]
]

{ #category : #accessing }
PenTreeTable >> sections [
	^ sections
]

{ #category : #accessing }
PenTreeTable >> sections: aCollection [
	sections := aCollection
]

{ #category : #accessing }
PenTreeTable >> showHeader [
	^ showHeader
]

{ #category : #accessing }
PenTreeTable >> showHeader: aBoolean [
	showHeader := aBoolean
]

{ #category : #accessing }
PenTreeTable >> treeSectionSelector [
	^ treeSectionSelector ifNil: [ treeSectionSelector := self sections first selector ]
]

{ #category : #accessing }
PenTreeTable >> treeSectionSelector: anObject [
	treeSectionSelector := anObject
]
