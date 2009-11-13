MXMLC = mxmlc
SRC = com/dungeonizer/DrawingCanvas.as     \
      com/dungeonizer/Dungeon.as           \
      com/dungeonizer/DungeonViewer.as     \
      com/dungeonizer/Entity.as            \
      com/dungeonizer/Map.as               \
      com/dungeonizer/Monster.as           \
      com/dungeonizer/Player.as            \
      com/dungeonizer/Vec.as               \
      FlexDungeonizer.as                   \
      TheDungeonizer.as
MAIN = Dungeonizer.mxml
SWF = TheDungeonizer.swf
PLAYER = "/Applications/Adobe Flash CS4/Players/Debug/Flash Player.app"

$(SWF) : $(MAIN) $(SRC)
	$(MXMLC) -incremental=true -o $(SWF) -- $(MAIN)

clean :
	touch $(SWF)
	rm $(SWF)

run : $(SWF)
	open -a $(PLAYER) $(SWF)
