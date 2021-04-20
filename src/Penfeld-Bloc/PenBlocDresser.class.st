Class {
	#name : #PenBlocDresser,
	#superclass : #PenDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocDresser >> background: aModel on: aComponent [
	"Default application of background"
	self background: aModel onBl: aComponent engineElement.
	
]

{ #category : #styling }
PenBlocDresser >> background: aModel onBl: anElement [
	aModel hasPaint
		ifTrue: [ 
			aModel hasImage 
				ifTrue: [ self buildCompositeBackground: aModel onBl: anElement ]
				ifFalse: [ self buildPaintBackground: aModel onBl: anElement ] ]
		ifFalse: [ 
			aModel hasImage 
				ifTrue: [ self buildImageBackground: aModel onBl: anElement ] ]
]

{ #category : #styling }
PenBlocDresser >> border: aModel on: aComponent [
	"Default application of border"
	self border: aModel onBl: aComponent engineElement.
	
]

{ #category : #styling }
PenBlocDresser >> border: aModel onBl: anElement [
	aModel allSidesAreUniform
		ifTrue: [ self buildBorder: aModel all onBl: anElement ]
		ifFalse: [ '<< border >> aModel is not uniform: not yet supported' ]
]

{ #category : #styling }
PenBlocDresser >> borderRadius: aModel on: aComponent [
	aModel allCornersAreUniform ifTrue: [ aComponent engineElement geometry: (BlRectangle cornerRadius: aModel allCorners value) ]
	
	
]

{ #category : #'private - styling' }
PenBlocDresser >> buildBorder: aBorderModel onBl: anElement [
	| builder paint |
	builder := BlBorderBuilder new
		paint: aBorderModel color asBlPaint;
		width: aBorderModel width value.
	anElement border: builder build
		
]

{ #category : #'private - styling' }
PenBlocDresser >> buildCompositeBackground: aModel onBl: anElement [
	self flag: #toDo
]

{ #category : #'private - styling' }
PenBlocDresser >> buildImageBackground: aModel onBl: anElement [
	aModel image isGradient ifFalse: [ self flag: #toDo. ^ self ].
	anElement background: aModel image asBlPaint.
]

{ #category : #'private - styling' }
PenBlocDresser >> buildPaintBackground: aModel onBl: anElement [
	anElement background: aModel color asBlBackground
]

{ #category : #accessing }
PenBlocDresser >> dressersMap [ 
	^ PenBlocDressersMap get
]

{ #category : #accessing }
PenBlocDresser >> eventStrategy [
	^ PenBlocEventStrategy
]

{ #category : #styling }
PenBlocDresser >> font: aModel on: aComponent [
	"Default application of font"
	self font: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> font: aModel onBl: anElement [
	"Default application of font"
	| textElement |
	textElement := anElement 
		childNamed: #text 
		ifFound: [ :child | child ]
		ifNone: [ '<< text >> There is no textElement initialized.' record. ^ self ].
		
	"font-family"
	textElement text fontName: aModel family value.
	
	"font-size"
	textElement text fontSize: aModel size value.
	
	"font-weight"
	textElement text perform: aModel weight value.
]

{ #category : #styling }
PenBlocDresser >> height: aModel on: aComponent [
	"Default application of height"
	self height: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> height: aModel onBl: anElement [
	anElement height: aModel value.
]

{ #category : #dressing }
PenBlocDresser >> hide: aComponent [
	aComponent engineElement visibility: BlVisibility hidden.
]

{ #category : #styling }
PenBlocDresser >> margin: aModel onBl: anElement [
	"Default application of margin"
	self flag: #toDo
]

{ #category : #styling }
PenBlocDresser >> outline: aModel on: aComponent [
	| outline |
	outline := BlElement new.
	self outline: aModel onBl: outline.
	aComponent engineElement addChildFirst: outline as: #outline. 
]

{ #category : #styling }
PenBlocDresser >> outline: aModel onBl: anElement [
	""
]

{ #category : #styling }
PenBlocDresser >> position: aModel on: aComponent [
	"Default application of position"
	self position: aModel onBl: aComponent engineElement.
	
]

{ #category : #styling }
PenBlocDresser >> position: aModel onBl: anElement [
	aModel position apply: aModel onBl: anElement
]

{ #category : #dressing }
PenBlocDresser >> show: aComponent [
	aComponent engineElement visibility: BlVisibility visible.
]

{ #category : #styling }
PenBlocDresser >> text: aModel on: aComponent [
	"Default application of text"
	self text: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> text: aModel onBl: anElement [
	| textElement |
	textElement := anElement 
		childNamed: #text 
		ifFound: [ :child | child ]
		ifNone: [ '<< text >> There is no textElement initialized.' record. ^ self].
		
	"text-align"
	aModel align apply: aModel onBl: textElement.
	
	"color"
	textElement text foreground: aModel color value.
]

{ #category : #styling }
PenBlocDresser >> width: aModel on: aComponent [
	"Default application of width"
	self width: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> width: aModel onBl: anElement [
	anElement width: aModel value.
]
