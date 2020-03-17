Extension { #name : #BrTextWordPieceStencilBuilder }

{ #category : #'*Penfeld-Bloc' }
BrTextWordPieceStencilBuilder >> buildDefault [
	^ BrTextElementWithCursors new
		text: self text;
		clipChildren: false;
		padding: self wordPadding;
		labelMeasurement;
		
		"to support event-handling attributes"
		addEventHandler: (BrTextEditorLineSegmentTextListener new editorElement: self editorElement);

		"editor requests to show a cursor as a result of its position change"
		addEventHandler: BrTextWordPieceShowCursorHandler uniqueInstance;
		
		"editor requests to remove a cursor as a result of its position change"
		addEventHandler: BrTextWordPieceHideCursorHandler uniqueInstance;
		
		"for screen position to cursor index transformation"
		addEventHandler: BrTextWordPieceScreenToCursorHandler uniqueInstance;

		addEventHandler: BrTextWordPieceFocusHandler uniqueInstance;
		addEventHandler: BrTextWordPieceBlurHandler uniqueInstance;
		
		"selection changed in the editor, select a given interval"
		addEventHandler: BrTextWordPieceSelectionHandler uniqueInstance;
		
		"selection changed in the editor, deselect a given interval"
		addEventHandler: BrTextWordPieceDeselectionHandler uniqueInstance;
		
		"text changed in the editor"
		addEventHandler: BrTextWordPieceTextChangeHandler uniqueInstance;		
		
		"when clicking inside of a text piece we should move cursor there and request editor focus"
		addEventHandler: mouseDownHandler;
		
		"when double-clicking inside of a text piece we should select the whole word"
		addEventHandler: doubleClickHandler;

		"text piece got inside of selected area"
		addEventHandler: selectionAcquiredHandler;

		"text piece got outside of then selected area"
		addEventHandler: selectionLostHandler;

		yourself
]
