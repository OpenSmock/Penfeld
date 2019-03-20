Class {
	#name : #CssStylesheet,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'rules',
		'medias',
		'origin'
	],
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssStylesheet class >> fromFile: aFilename [
	^ self new
]

{ #category : #'as yet unclassified' }
CssStylesheet class >> origin: anOrigin [
	^ self new
		origin: anOrigin;
		yourself
]

{ #category : #comparing }
CssStylesheet >> <= aStylesheet [
	^ self origin <= aStylesheet origin
]

{ #category : #comparing }
CssStylesheet >> >= aStylesheet [
	^ self origin >= aStylesheet origin
]

{ #category : #accessing }
CssStylesheet >> file [
	^ file
]

{ #category : #accessing }
CssStylesheet >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
CssStylesheet >> for: aSelectorString style: aBlock [
	| theSelectors theRule |
	theSelectors := CSSParser parseSelectors: aSelectorString.
	theRule := CSSRule new.
	theRule
		selectors: theSelectors;
		stylesheet: self.
	aBlock value: theRule.
	self rules add: theRule
]

{ #category : #'initialize-release' }
CssStylesheet >> initialize [
	super initialize.
	rules := OrderedCollection new.
	medias := OrderedCollection new.
	origin := CssOrigin USER
]

{ #category : #'as yet unclassified' }
CssStylesheet >> matchingMediaRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self medias do: [ :m |  m rules do: [ :r | 
					r selectors
						detect: [ :s | s matchesStyleable: aStyleable ]
						ifFound: [ :s |  matchedRules add:
									(CSSMatchedRule new
										selector: s;
										declarations: r declarations;
										transitions: r transitions;
										conditions: m conditions;
										yourself) ] ] ].
	^ matchedRules
]

{ #category : #'as yet unclassified' }
CssStylesheet >> matchingRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self rules do: [ :r |  r selectors
				select: [ :s | s matchesStyleable: aStyleable ]
				thenDo: [ :s |  matchedRules add:
							(CssMatchedRule new
								selector: s;
								declarations: r declarations;
								transitions: r transitions;
								yourself) ] ].
	matchedRules addAll: (self matchingMediaRulesFor: aStyleable).
	^ matchedRules
]

{ #category : #accessing }
CssStylesheet >> medias [
	^ medias
]

{ #category : #accessing }
CssStylesheet >> medias: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self medias add: r ]
]

{ #category : #accessing }
CssStylesheet >> name [
	^ name
]

{ #category : #accessing }
CssStylesheet >> name: anObject [
	name := anObject
]

{ #category : #accessing }
CssStylesheet >> origin [
	^ origin
]

{ #category : #accessing }
CssStylesheet >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
CssStylesheet >> rules [
	^ rules
]

{ #category : #accessing }
CssStylesheet >> rules: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self rules add: r ]
]
