Extension { #name : #BlTextElement }

{ #category : #'*Penfeld-Bloc' }
BlTextElement >> measureParagraph: anExtentMeasurementSpec [
	"If I am executed it means that measurement specification changed.
	We have to recreate a text layout with new parameters"
	| aMaxWidth aMaxHeight aWidthSpec aHeightSpec aPadding aMeasuredWidth aMeasuredHeight aMeasuredExtent aMeasuredBounds aParagraph |

	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := self constraints padding.
	
	aMaxWidth := self computeMaxWidth: anExtentMeasurementSpec.
	aMaxHeight := self computeMaxHeight: anExtentMeasurementSpec.

	aParagraph := paragraph
		"Create a new text layout"
		ifNil: [ paragraph := self acquireParagraph ]
		"or reuse existing"
		ifNotNil: [ paragraph reset ].

	aParagraph
		baseline: self baseline;
		text: self text;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight;
		scale: self globalScale.

	aParagraph measureOn: self measurer.
	"text layout is measured at this point"

	aMeasuredBounds := measurement boundsOf: aParagraph.
	aMeasuredWidth := aMeasuredBounds width min: aMaxWidth.
	aMeasuredHeight := aMeasuredBounds height min: aMaxHeight.

	"If measurement spec is exact I must ignore size measured by textLayout"
	aWidthSpec isExact ifTrue: [ 
		aMeasuredWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ 
		aMeasuredHeight := aHeightSpec size ].

	"Take minimal width and height into account"
	aMeasuredWidth := aMeasuredWidth max: self constraints minWidth - aPadding width.
	aMeasuredHeight := aMeasuredHeight max: self constraints minHeight - aPadding height.
	aMeasuredExtent := aMeasuredWidth @ aMeasuredHeight.
	"Take padding into account"
	aMeasuredExtent := aMeasuredExtent + (aPadding width @ aPadding height).

	"Finally set measured extent"
	self measuredExtent: aMeasuredExtent.
]
