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
	background ifNotNil: [ aModel interactor background: background ]
]

{ #category : #dressing }
PenDBlocTreeTable >> applyStyle: aStyle [
	| background border |
	background := self getBackground: aStyle.
	background ifNotNil: [ self model interactor background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ self model interactor border: border.
		self model interactor outskirts: BlOutskirts outside. ].
]

{ #category : #dressing }
PenDBlocTreeTable >> doBeforeApplyStyle [
	| listElements i |
	i := 0.
	listElements := self model getExpandedNodesAsList collect: [ :item | 
		i = 0 
			ifTrue: [ i := 1 ]
			ifFalse: [ i := 0. self applyOddStyleOn: item ].
		item interactor ].
	self model showHeader ifTrue: 
		[ listElements addFirst: self model header interactor ].
	dataSource elements: listElements.
	self model interactor dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #initialization }
PenDBlocTreeTable >> initInteractor [
	dataSource := PFInfiniteDataSource new.
	
	self model interactor: PFInfiniteListElement new.
	self model interactor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
]
