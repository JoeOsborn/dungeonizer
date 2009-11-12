MXMLC = mxmlc
SRC = com/dungeonizer/Map.as               \
      FlexDungeonizer.as
MAIN = TheDungeonizer.mxml
SWF = TheDungeonizer.swf
PLAYER = "/Applications/Adobe Flash CS4/Players/Debug/Flash Player.app"

$(SWF) : $(MAIN) $(SRC)
	$(MXMLC) -incremental=true -o $(SWF) -- $(MAIN)

clean :
	touch $(SWF)
	rm $(SWF)

run : $(SWF)
	open -a $(PLAYER) $(SWF)
