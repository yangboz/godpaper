[NEW]:Upgrade the Starling version from 1.0 to 1.1;

[CHANGE]:AS3 mouse event to Starling touch event;

[CHANGE]:FLEX4 event(elementAdd,elementRemove) to Starling native event(addToStage,removeToStage);

[CHANGE]:Upgrade the assets version to compatible 1x and 2x version;

[NEW]:ChessFactoryBase with chessPieceSubType variable for customize the chess piece sub typed texture/skin;

[CHANGE]:ChessGasket only reference on ChessPiece,deprecated the container responsibility;

[CHANGE]:Using the TouchEvent with phase handler to replace of the FLEX DragDrop implementation;

[CHANGE]:Using the parsley/spicelib-flash-2.3.2.swc Logging function to replace of LogUtil;

[CHANGE]:Using the as3 signal mechanic to replace of Parsley [MessageHandler] meta-data;

[CHANGE]:While removing the eat-off chess piece,using its reference to replace of getChild/ElementAt function;

[CHANGE]:Abstract the x,y and label properties to  IVisualElement.as;

[DELETE]:FLEX3 UIComponent's CREATE_COMPLETE event;

[CHANGE]:Using the TouceEvent.TRIGGLE to replace of the MouseEvent.MOUSE_DOWN/MOUSE_CLICK event listeners and handlers;

[NEW]:Using the simplified FLEX logging package to replace of the Parsley/SpiceLib flash logging mechanics;

[CHANGE]:Simplify the ApplicationBase startup process,left the initializeHandler and applicationComplateHandler to override;

[CHANGE]:Remove the view components(ChessGasket,ChessBoard,ChessPieces) related initial and tasks to GameScene addToStageHandler;
 