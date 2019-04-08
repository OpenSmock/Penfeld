Class {
	#name : #StyleStylesheet,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'rules',
		'medias',
		'origin'
	],
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleStylesheet class >> fromFile: aFilename [
	^ self new
]

{ #category : #'as yet unclassified' }
StyleStylesheet class >> origin: anOrigin [
	^ self new
		origin: anOrigin;
		yourself
]

{ #category : #comparing }
StyleStylesheet >> <= aStylesheet [
	^ self origin <= aStylesheet origin
]

{ #category : #comparing }
StyleStylesheet >> >= aStylesheet [
	^ self origin >= aStylesheet origin
]

{ #category : #accessing }
StyleStylesheet >> file [
	^ file
]

{ #category : #accessing }
StyleStylesheet >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
StyleStylesheet >> for: aSelectorString style: aBlock [
	| theSelectors theRule |
	theSelectors := StyleParser parseSelectors: aSelectorString.
	theRule := StyleRule new.
	theRule
		selectors: theSelectors;
		stylesheet: self.
	aBlock value: theRule.
	self rules add: theRule
]

{ #category : #'initialize-release' }
StyleStylesheet >> initialize [
	super initialize.
	rules := OrderedCollection new.
	medias := OrderedCollection new.
	origin := StyleOrigin USER
]

{ #category : #'as yet unclassified' }
StyleStylesheet >> matchingMediaRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self medias do: [ :m |  m rules do: [ :r | 
					r selectors
						detect: [ :s | s matchesStyleable: aStyleable ]
						ifFound: [ :s |  matchedRules add:
									(StyleMatchedRule new
										selector: s;
										declarations: r declarations;
										transitions: r transitions;
										conditions: m conditions;
										yourself) ] ] ].
	^ matchedRules
]

{ #category : #'as yet unclassified' }
StyleStylesheet >> matchingRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self rules do: [ :r |  r selectors
				select: [ :s | s matchesStyleable: aStyleable ]
				thenDo: [ :s |  matchedRules add:
							(StyleMatchedRule new
								selector: s;
								declarations: r declarations;
								transitions: r transitions;
								yourself) ] ].
	matchedRules addAll: (self matchingMediaRulesFor: aStyleable).
	^ matchedRules
]

{ #category : #accessing }
StyleStylesheet >> medias [
	^ medias
]

{ #category : #accessing }
StyleStylesheet >> medias: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self medias add: r ]
]

{ #category : #accessing }
StyleStylesheet >> name [
	^ name
]

{ #category : #accessing }
StyleStylesheet >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StyleStylesheet >> origin [
	^ origin
]

{ #category : #accessing }
StyleStylesheet >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
StyleStylesheet >> rules [
	^ rules
]

{ #category : #accessing }
StyleStylesheet >> rules: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self rules add: r ]
]
