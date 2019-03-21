Class {
	#name : #StyleStylesheetContainer,
	#superclass : #OrderedCollection,
	#instVars : [
		'styleable'
	],
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StyleStylesheetContainer class >> on: aStyleable [
	^ self new
		styleable: aStyleable;
		yourself
]

{ #category : #'adding/removing' }
StyleStylesheetContainer >> add: aStylesheet [
	super add: aStylesheet.
	
]

{ #category : #'adding/removing' }
StyleStylesheetContainer >> addAll: aCollection [
	super addAll: aCollection.
]

{ #category : #'as yet unclassified' }
StyleStylesheetContainer >> computeStyleNodes [
	^ self computeStyleNodesFrom: self styleable
]

{ #category : #'as yet unclassified' }
StyleStylesheetContainer >> computeStyleNodesFrom: aNode [
	| aStylesheetList parent |
	aStylesheetList := OrderedCollection new.
	parent := aNode parent.
	[ parent isNotNil ] whileTrue: [ 
		aStylesheetList addAll: parent stylesheets.
		parent := parent parent ].
	^ self computeStyleNodesFrom: aNode stylesheets: aStylesheetList ordinal: 0.
]

{ #category : #'as yet unclassified' }
StyleStylesheetContainer >> computeStyleNodesFrom: aStyleable stylesheets: aStylesheetList [
	| rootNode matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	aStylesheetList addAll: aStyleable stylesheets.
	aStylesheetList do: [ :eachStylesheet | matchedRules addAll: (eachStylesheet matchingRulesFor: aStyleable) ].
	rootNode := aStyleable styler.
	matchedRules do: [ :r | 
			rootNode styles addAll: (r computedStyles reject: [ :s | rootNode styles includes: s ]).
			rootNode transitions addAll: (r computedTransitions reject: [ :t | rootNode transitions includes: t ]) ].
	aStyleable isParent ifTrue:[
		aStyleable children do: [ :eachChild | rootNode children add: (self computeStyleNodesFrom: eachChild stylesheets: aStylesheetList) ]].
	^ rootNode
]

{ #category : #'as yet unclassified' }
StyleStylesheetContainer >> computeStyleNodesFrom: aStyleable stylesheets: aStylesheetList ordinal: anInteger [
	| rootNode matchedRules ordinal|
	ordinal := anInteger.
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	aStylesheetList addAll: aStyleable stylesheets.
	aStylesheetList do: [ :eachStylesheet | matchedRules addAll: (eachStylesheet matchingRulesFor: aStyleable) ].
	rootNode := aStyleable styler.
	matchedRules do: [ :r | 
			rootNode styles addAll: 
				((r computedStyles do:[:s| s ordinal: (ordinal := ordinal +1) ]) 
					reject: [ :s | rootNode styles includes: s ]).
			rootNode transitions addAll: 
				((r computedTransitions do:[:s| s ordinal: (ordinal := ordinal +1) ])
					reject: [ :t | rootNode transitions includes: t ]) ].
	aStyleable isParent ifTrue:[
		aStyleable children do: [ :eachChild | 
			rootNode children add: 
				(self computeStyleNodesFrom: eachChild stylesheets: aStylesheetList ordinal:ordinal) ]].
	^ rootNode
]

{ #category : #'as yet unclassified' }
StyleStylesheetContainer >> initialize [
	super initialize.
	super add: (CSSStylesheet origin: CSSOrigin USER).
]

{ #category : #'adding/removing' }
StyleStylesheetContainer >> remove: aStylesheet [
	super remove: aStylesheet.
]

{ #category : #'adding/removing' }
StyleStylesheetContainer >> removeAll [
	super removeAll.
]

{ #category : #'adding/removing' }
StyleStylesheetContainer >> removeAll: aCollection [
	super removeAll: aCollection.
]

{ #category : #accessing }
StyleStylesheetContainer >> styleable [
	^ styleable
]

{ #category : #accessing }
StyleStylesheetContainer >> styleable: anObject [
	styleable := anObject
]

{ #category : #'as yet unclassified' }
StyleStylesheetContainer >> userStylesheet [
	^ self first
]
