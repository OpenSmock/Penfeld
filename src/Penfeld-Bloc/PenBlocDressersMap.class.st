Class {
	#name : #PenBlocDressersMap,
	#superclass : #PenDressersMap,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #initialization }
PenBlocDressersMap >> initMap [
	map
		at: PenContainer put: PenBlocContainerDresser ;
		at: PenWindow put: PenBlocMorphicWindowDresser ;
		at: PenLabel put: PenBlocLabelDresser ;
		at: PenButton put: PenBlocButtonDresser ;
		at: PenToggleButton put: PenBlocButtonDresser ;
		at: PenCheckBox put: PenBlocCheckBoxDresser ;
		at: PenList put: PenBlocListDresser ;
		at: PenTable put: PenBlocTableDresser ;
		at: PenTableItem put: PenBlocTableItemDresser ;
		at: PenTableItemHeader put: PenBlocTableItemDresser ;
		at: PenTree put: PenBlocTreeDresser ;
		at: PenTreeNode put: PenBlocTreeNodeDresser ;
		at: PenTreeTable put: PenBlocTreeTableDresser ;
		at: PenTreeTableNode put: PenBlocTreeTableNodeDresser ;
		at: PenComboBox put: PenBlocComboBoxDresser ;
		at: PenRadioButton put: PenBlocRadioButtonDresser ;
		at: PenProgressBar put: PenBlocProgressBarDresser ;
		at: PenSlider put: PenBlocSliderDresser;
		at: PenImage put: PenBlocImageDresser
]
