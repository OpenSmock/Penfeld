Class {
	#name : #PenExamplesViewer,
	#superclass : #SpPresenter,
	#instVars : [
		'pragmaCollector',
		'list',
		'space',
		'blocPane'
	],
	#category : #'Penfeld-Bloc-Tests-Examples'
}

{ #category : #specs }
PenExamplesViewer class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #list;
		add: #blocPane;
		yourself
]

{ #category : #examples }
PenExamplesViewer class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #initialization }
PenExamplesViewer >> connectPresenters [
	list
		whenSelectionChangedDo: [ :selection | | method selector testClass element |
			method := selection selectedItem.
			selector := method selector. 
			testClass := method methodClass new.
			testClass setUp.
			[ element := testClass perform: selector.
			space root removeChildren.
			element ifNotNil: [ space root addChild: element ] ]
				ensure: [ testClass tearDown ]. ]
]

{ #category : #initialization }
PenExamplesViewer >> initialize [
	pragmaCollector := (PragmaCollector new
		filter: [ :pragma | pragma selector = #PenExample ]) 
		reset.
	super initialize.
]

{ #category : #initialization }
PenExamplesViewer >> initializePresenters [
	| host morph |
	list := self newList.
	list
		items: (pragmaCollector collect: [ :p | p method ]);
		sortingBlock: [ :a :b | a asString < b asString ];
		display: [ :item | item printString ].
		
	morph := Morph new.
	blocPane := self newMorph morph: morph.
	host := BlMorphicHost new containerMorph: morph.
	space := BlSpace new host: host.
	space root: (BlElement new size: 500@500).
	space show.
]

{ #category : #api }
PenExamplesViewer >> title [
	
	^ 'Penfeld examples'.
]
