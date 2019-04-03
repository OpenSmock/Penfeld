Class {
	#name : #PenTree,
	#superclass : #PenInteractionElement,
	#instVars : [
		'root',
		'showRoot',
		'propagateCollapse',
		'sortingBlock'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #building }
PenTree >> build [
	self stylesheet ifNil: [ self chooseStylesheet ].
	self root build.
	self isShownRoot ifFalse: [ self root doExpand ].
	super build
]

{ #category : #api }
PenTree >> deepLevel [
	^ self isShownRoot 
		ifTrue: [ 0 ]
		ifFalse: [ -1 ]
]

{ #category : #api }
PenTree >> expandAll [
	self root expandAll
]

{ #category : #accessing }
PenTree >> getExpandedNodesAsList [
	| list |
	list := OrderedCollection new.
	self isShownRoot ifTrue: [ list add: self root ].
	self root isExpanded ifTrue: [ list addAll: self root getExpandedNodesAsList ].
	^ list
]

{ #category : #initialization }
PenTree >> initialize [
	super initialize.
	root := PenTreeNode new parent: self.
	showRoot := false.
	propagateCollapse := false.
	sortingBlock := [ :a :b | true ]
]

{ #category : #testing }
PenTree >> isPropagatedCollapse [
	^ self propagateCollapse
]

{ #category : #testing }
PenTree >> isShownRoot [
	^ self showRoot
]

{ #category : #accessing }
PenTree >> nodes [
	^ self root sortedNodes
]

{ #category : #'api - events' }
PenTree >> onSelectionChangedDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol selectionChanged
]

{ #category : #accessing }
PenTree >> propagateCollapse [
	^ propagateCollapse
]

{ #category : #accessing }
PenTree >> propagateCollapse: aBoolean [
	propagateCollapse := aBoolean
]

{ #category : #building }
PenTree >> refreshAllNodes [
	self root refresh.
	super refresh
]

{ #category : #accessing }
PenTree >> root [
	^ root
]

{ #category : #accessing }
PenTree >> root: aTreeNode [
	root := aTreeNode.
	aTreeNode parent: self.
	self isShownRoot ifFalse: [ self root doExpand ]
]

{ #category : #accessing }
PenTree >> showRoot [
	^ showRoot
]

{ #category : #accessing }
PenTree >> showRoot: aBoolean [
	showRoot := aBoolean
]

{ #category : #accessing }
PenTree >> sortingBlock [
	^ sortingBlock
]

{ #category : #accessing }
PenTree >> sortingBlock: anObject [
	sortingBlock := anObject
]

{ #category : #accessing }
PenTree >> styleName [
	^ #tree
]

{ #category : #accessing }
PenTree >> tree [
	^ self
]
