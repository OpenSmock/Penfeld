Class {
	#name : #PenDBlocTreeTable,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocTreeTable class >> styleSelector [
	^ #table
]

{ #category : #dressing }
PenDBlocTreeTable >> applyOddStyleOn: aModel [
	| style background |
	style := aModel stylesheet declarations at: 'tr:nth-child(odd)' ifAbsent: [ ^self ].
	background := self getBackground: style.
	background ifNotNil: [ aModel engineElement background: background ]
]

{ #category : #dressing }
PenDBlocTreeTable >> applyStyle: aStyle [
	| background border |
	background := self getBackground: aStyle.
	background ifNotNil: [ self model engineElement background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ self model engineElement border: border.
		self model engineElement outskirts: BlOutskirts outside. ].
]

{ #category : #dressing }
PenDBlocTreeTable >> doBeforeApplyStyle [
	| listElements i |
	i := 0.
	listElements := self model getExpandedNodesAsList collect: [ :item | 
		i = 0 
			ifTrue: [ i := 1 ]
			ifFalse: [ i := 0. self applyOddStyleOn: item ].
		item engineElement ].
	self model showHeader ifTrue: 
		[ listElements addFirst: self model header engineElement ].
	dataSource elements: listElements.
	self model engineElement dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #initialization }
PenDBlocTreeTable >> initEngineElement [
	dataSource := PFInfiniteDataSource new.
	
	self model engineElement: PFInfiniteListElement new.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
]
