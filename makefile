MXMLC = /Applications/Adobe\ Flex\ Builder\ 3/sdks/3.2.0/bin/mxmlc
SRC = com/dungeonizer/Dungeon.as           \
      com/dungeonizer/DungeonViewer.as     \
      com/dungeonizer/Entity.as            \
      com/dungeonizer/Map.as               \
      com/dungeonizer/Vec.as               \
      FlexDungeonizer.as
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
