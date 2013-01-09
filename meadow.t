#charset "us-ascii"
#include <tads.h>

#include "advlite.h"

/* A secondary area of the game to test out some other things. */

countryside: Region
;

meadowRegion: SenseRegion
;

fieldRegion: SenseRegion
;

sun: MultiLoc, Distant 'sky; blue cloudless bright; sun; it'
    "The sun glares down from the cloudless blue sky above. "
    locationList = [countryside]
;
    
meadow: Room 'Meadow' 'meadow'
    "<<first time>>You've no idea how you got here, nor do you recognize this
    place.<<only>> Tall grass and wild flowers grow in profusion, forming an
    even carpet that slopes down towards a riverbank to what you instinctively
    think of as the east. To the south lies a thick band of trees, a large
    wood or perhaps even a forest. To the north is another field, while a steep
    hill rises up a short way off to the west. "
    
    east = riverbank
    south = forestPath
    west = hillsideFromMeadow
    north = field
    
    regions = [countryside, meadowRegion]
;

     
+ Decoration 'flora; wild tall lush; grass flowers; them'
    "Tall grass and wild flowers grow in profusion here, looking particularly
    lush as if they have enjoyed plenty of both rain and sunshine in the early
    part of the summer. "
;

+ hillsideFromMeadow: StairwayUp 'steep hill;; hillside'
     destination = hillside
;

+ Enterable 'forest; thick of[prep]; band trees wood woodland'
    "Something tells you that such a thick band of trees must be more than just
    a small wood. "
    
    connector = forestPath
;

hillside: Room 'Hillside' 'hillside'
    "Halfway up the hillside you can see clear across the meadow and beyond the
    river to the east. You can also see that the woodland to the south is a
    great forest, stretching as far as the eye can see. From here you can
    go west up towards the summit or east back down to the meadow. "
    
    east = hillsideToMeadow
    down asExit(east)
    
    west = summit
    up asExit(west)
    
    regions = [countryside]
;

+ hillsideToMeadow: StairwayDown 'slope'

    destination = meadow
    
;

summit: Room 'Summit' 'summit'
    "Standing at the summit affords you an excellent view of the surrounding
    countryside, which stretches as far as you can see in all directions. The
    hill falls away sheer to north, south and west, looking down into a deep
    gully to the southwest, so that the only practicable way down seems to be to
    the east. "
    
    east = hillside
    down asExit(east)
    
    regions = [countryside]
;

riverbank: Room 'Riverbank' 'riverbank;;bank'
    "A broad river runs lazily by just to the west. The way south is blocked by
    a thick belt of trees extending all the way down to the water's edge, but
    there's nothing to stop you carrying along the riverbank to the north, or
    wandering off west towards the meadow. "
    
    west = meadow
    north = marsh
    
//    inRoomName(pov) { return 'down by the riverbank'; }
    
    regions = [countryside, meadowRegion]
    
//    remoteContentsLister = static new CustomRoomLister(nil, prefixMethod: 
//        method(lst, pl, irName) 
//        { "<.p>Lying close to the riverbank <<if pl>>are<<else>>is<<end>> "; })
    
    remoteContentsLister = new CustomRoomLister('\^', suffixMethod: method(lst,
        pl, irName) { " <<if pl>>lie<<else>>lies<<end>> abandoned down by the
            riverbank. "; })
                                                
;

marsh: Room 'Marsh' 'marsh'
    "The riverbank is so low-lying at this point that the river has overflowed
    its banks, creating the area of marshland you now find yourself in. To the
    north it becomes too deep to wade through, but you could follow the
    riverbank to the south, or make your way to the drier ground to the west. "
    
    west = field
    south = riverbank
    
    regions = [countryside, fieldRegion]
;

field: Room 'Wheat Field' 'wheat field'
    "The field is flat and full of ripening wheat, although down by the river to
    the east it becomes a soggy marsh where the river has burst its banks. To
    the south lies an open meadow, while a tall paling fence surrounds the field
    to north and west, presumably to keep out intruders, or possibly just to
    prevent livestock from trampling the wheat. There is, however, a gate
    through the fence in the  northwestern corner. "
    east = marsh
    south = meadow
    northwest = fieldGate
    regions = [countryside, fieldRegion]
;

+ Decoration 'wheat; ripening; crop'     
;

+ crows: Decoration 'crows; nasty big black; birds; them'
    "Nasty big black things. You never did like them, even since one scared you
    as a child. "
    
    sightSize = large
    soundSize = large
    
    listenDesc = "The horrid crows are making the most ugly, raucous cawing
        sound. "
    
    remoteListenDesc(pov)
    {
        "You hear the raucous sound of crows cawing up in the field. ";
    }
    
    remoteDesc(pov)
    {
        "The ones you can see are mostly flying around low over the field, as if
        intent on annoying the unfortunate scarecrow. ";
    }
    
    decorationActions = [Examine, ListenTo]
    
    notImportantMsg = 'You make it a point of principle to ignore all crows;
        only that way can you show the full extent of your contempt for the
        horrid things. '
;


+ Fixture 'fence; tall paling'
    
    cannotClimbMsg = '''It's too tall to climb over, and it's hard to get a
        purchase anywhere. '''
;


+ fieldGate: Door 'gate'
    
    otherSide = trackGate
;

farmTrack: Room 'Farm track' 'farm track; muddy'
    "Despite the blazing sunshine, this track seems very muddy, suggesting that
    there may have been recent heavy rainfall. To the southeast the track leads
    through a gate, while to the northwest it carries on past tall hedgerows. "
    
    southeast = trackGate
    northwest = farmyard
    
    regions = [countryside]
;

+ trackGate: Door 'gate'
    
    otherSide = fieldGate
    
    beforeTravel(traveler, connector)
    {
        if(traveler == gPlayerChar && connector not in (self, field) && isOpen)
        {
            "You really shouldn't wander off leaving the gate open, you know. ";
            exit;
        }
    }
;

farmyard: Room 'Farmyard' 'farmyard; farm; yard'
    "This is clearly a farmyard, with a barn just off to the east and the
    farmhouse immediately to the north, but it seems quite deserted. One farm
    track leads back to the southeast and a more substantial path leads west,
    while a track leads round the side of the house to the northeast. "

    southeast = farmTrack
    east = barn
    west = road
    northeast = sideTrack
    north = farmhouseFrontDoor
    regions = [countryside]
;

+ Enterable 'barn'
    
    connector = barn
;

+ Enterable 'farmhouse; ;house'
    
    connector = farmhouseFrontDoor
;

+ farmhouseFrontDoor: Door 'farmhouse door'
    
    otherSide = farmhouseBackDoor
    lockability = lockableWithKey
    isLocked = true
;


barn: Room 'Barn' 'barn'
    "The barn is basically a big open space with a way out to the west. <<if
      ladder.isDirectlyIn(barn) && ladder.isFixed>> A long wooden ladder leads
    up to the hay loft above<<else>> There's also a hay loft but right now
    there's no way up to it<<end>>. "
    
    west = farmyard
    out asExit(west)
    up = ladder
    
;

+ ladder: StairwayUp 'long wooden ladder; sturdy ;rungs'
    "It looks in good shape, with sturdy-looking rungs set not too far apart.
    <<if isFixed>> It's also screwed firmly to the loft supports.<<end>> "
    
    
    isFixed = true
    
    destination = loft
    
    makeScrewed(stat) 
    { 
        isFixed = stat; 
        if(stat)
        {
            barn.up = ladder;
            loft.down = barn;
            ladder.destination = loft;
        }
        else
        {
            barn.up = nil;
            loft.down = nil;
            ladder.destination = nil;   
        }
    }
    
    isScrewable = true
    
    dobjFor(Screw)
    {
        verify()
        {
            inherited;
            if(isFixed)
                illogicalNow('The ladder is already screwed in place. ');
        }
        
        check() { "You'll need something to screw it with. "; }
        
    }
    
    dobjFor(ScrewWith)
    {
        verify() { verifyDobjScrew(); }
        
        check()
        {
            if(!isIn(barn))
                "There's nothing to screw it to here. ";
        }
        
        action()
        {
            moveInto(barn);
            makeScrewed(true);           
            "You screw the ladder firmly back in place. ";
        }
    }
    
    dobjFor(Fasten) asDobjFor(Screw)
    
    dobjFor(Unscrew)
    {
        verify()
        {
            inherited;
            if(!isFixed)
                illogical('The ladder isn\'t screwed to anything. ');
        }
        
        check() { "You'll need something to unscrew it with. "; }
    }
    
    dobjFor(Unfasten) asDobjFor(Unscrew)
    
    dobjFor(UnscrewWith)
    {
        verify() { verifyDobjUnscrew(); }
        
        action()
        {
            makeScrewed(nil);
           
            
            "You unscrew the ladder from its fastenings and it topples over to
            lie lengthways across the ground. ";
        }
        
    }
    
    canClimb = (destination != nil)
    
    cannotClimbMsg = 'The ladder doesn\'t lead anywhere right now. '
    
    specialDesc = "The long wooden ladder <<if location == rearOfHouse>> is
        propped up against the side of the house<<else>>lies on the
        ground<<end>>. "
    
    useSpecialDesc = (!isFixed && location.ofKind(Room))
;

+ Fixture 'loft supports;;;them'
    
;


loft: Room 'Hay Loft' 'hay loft'
    "There's not much up here, apart from a few stray strands of straw
    scattered across the bare boards<<if !sack.moved>>, and an old sack lying
    abandoned over in the corner<<end>>. A ladder leads back down to the
    main part of the barn below. "
    down = ladderDown
    
;

+ Decoration 'straw; stray of; strands'
;
    
+ Decoration 'bare boards;;them'
;

+ ladderDown: StairwayDown 'ladder'
    destination = barn
;

+ sack: Container 'old sack'
    
    isListed = (moved)
    hiddenUnder = [oilcan]
;

oilcan: Thing 'oilcan; ; oil can'
    
    isPourable = true
;

sideTrack: Room 'Track by Side of House' 'track[n] by the side[n] of the house'    
    "This narrow track runs round the side of the house from southwest to
    northwest. "
    
    southwest = farmyard
    northwest = rearOfHouse
    
    regions = [countryside]
;


rearOfHouse: Room 'Rear of House' 'rear[n] of the house'
    "The back of the farmhouse stands immediately to the south, with a small
    back yard just to the north, while narrow paths lead round the house to
    southeast and southwest. There are no obvious signs of life in the house,
    but one of the windows on the top floor is slightly ajar. "
    
    southeast = sideTrack
    southwest = road
    north = garden
    south = farmhouseBackDoor
    
    regions = [countryside, yardRegion]
    
    roomAfterAction()
    {
        if(gActionIs(Drop) && gDobj == ladder)
        {
            "You carefully prop the ladder up against the side of the house so
            it leads up to the window ledge above. It feels firm enough when
            you test it. ";
            
            ladder.destination = windowLedge;
        }
    }
    
;

+ Enterable 'farmhouse; granite; house'
    "It's a solidly-built two-storey house, apparently made of granite. The back
    door looks firmly locked and there are no obvious signs of life inside, but
    one of the windows on the top floor is slightly ajar. "
    connector = farmhouseBackDoor
    
    sightSize = large
;

+ farmhouseBackDoor: Door 'door'
    
    lockability = lockableWithKey
    isLocked = true
    otherSide = farmhouseFrontDoor
    
;

+ Distant 'window; ajar; smoke'
    "One of the windows on the top floor -- almost certainly a bedroom window --
    is slightly ajar. There seems to be a bit of smoke coming through it. "
;

windowLedge: Room 'Window Ledge' 'window ledge'
    "You balance precariously at the top of the ladder just by the window ledge,
    next to a window that's open just a fraction. "
    
    down = rearOfHouse
;

+ Enterable 'window'
    
    connector: TravelConnector {
    
        destination = bedroom
        
        travelDesc()
        {
            "You tumble in through the window and land on the floor,
            feeling momentarily disoriented, not least because the room is full
            of smoke. Once you stop coughing enough to get your bearings you
            find to your surprise that you're back in your own bedroom.\b";
            
            local lst = gPlayerChar.listableContents;
            foreach(local cur in lst)
                cur.moveInto(windowLedge);
        }
    }
    
    isOpenable = true
    isOpen = nil
    
    dobjFor(Enter)
    {
        preCond = [objOpen]
    }
    
    dobjFor(GoThrough) asDobjFor(Enter)
    
    nothingThroughMsg = '''You can't see much through the window since the room
        beyond seems full of smoke. '''
;

garden: Room 'Back Yard' 'back yard'
    "This back yard looks like the sort of place a farmer might keep chickens,
    but there's nothing here but an empty chicken coop. The rear of the house is
    just to the south. "
    
    south = rearOfHouse
    
    regions = [countryside, yardRegion]
;

+ Decoration 'chicken coop; empty'
    "From the look of it you doubt any fowl have been near it for years. "
;

yardRegion: SenseRegion
;



road: Room 'Road' 'road'
    "This road runs east towards the farmstead and west as far as you can see,
    alonsgide a patch of scrubland immediately to the south. There's also a
    narrow track running off to the northeast. "
    
    east =  farmyard
    northeast = rearOfHouse
    south = scrubland
    
    
    west() { "You traipse down the road <<one of>>for a while<<or>>
        again<<stopping>>, but since it <<one of>><<or>>still<<stopping>> seems
        to go on and on and on without arriving at anywhere interesting you
        <<one of>>eventually<<or>>once again<<stopping>> turn round and come
        back. "; }
    
    regions = [countryside]
;

+ toolbox: OpenableContainer 'toolbox; rusty old; box hinges'
    
    initSpecialDesc = "A rusty old toolbox lies abandoned by the side of the
        road. "
    
    isRusted = true
    
    dobjFor(Open)
    {
        check()
        {
            if(isRusted)
                "The toolbox appears to be rusted shut. ";
        }        
    }
    
    
    iobjFor(PourOnto)
    {
        check()
        {
            if(gDobj != oilcan)
                "That seems unlikely to do much good. ";
        }
        
        action()
        {
            isRusted = nil;
            "You pour a little of the oil onto the toolbox, paying special
            attention to its hinges. ";
        }
    }
;

++ screwdriver: Thing 'large screwdriver'
    
    canScrewWithMe = true
;



scrubland: Room 'Scrubland' 'scrubland'
    "This scrubland is entirely unremarkable. To the north it dips down towards
    a road, while to the south it gently rises towards some foothills. "
    
    north = road
    south = foothill
    
    regions = [countryside]
;
    


//------------------------------------------------------------------------------

forestPath: Room 'Forest Path' 'forest path'
    "The path runs straight north and south through the trees for quite a way,
    though you can see little to either side apart from the trees, with the
    exception of a narrow path branching off to the west. "
    
    north = meadow
    south = clearing
    west = narrowPath
    
    cannotGoThatWayMsg = 'You fear that you might soon become lost among the
        trees if you stray from the path. '
    
    regions = [countryside]
;

+ Decoration 'trees;;them'
;

narrowPath: Room 'Narrow Path' 'narrow path'
    "This narrow path runs more or less east and west through densely packed
    foliage. "
    east = forestPath
    west = junction
    cannotGoThatWayMsg = 'The trees on either side are too densely packed
        together for you to leave the path. '
    
    regions = [countryside]
;

clearing: Room 'Small Clearing' 'small clearing'
    "Several paths meet at this clearing, including ones leading north, south
    and northeast. "
    
    north = forestPath
    northeast = overgrownTrack
    south = leafyPath
        
    regions = [countryside]
;

leafyPath: Room 'Leafy Path' 'leafy path'
    "This leafy, leaf-strewn path meanders gently north and south through the
    dense forest. "
    north = clearing
    south = glade
    regions = [countryside]
;

glade: Room 'Large Glade' 'large glade' 
    "One giant wych elm dominates the centre of this glade, standing proud and
    apart from all the other trees round its rim. The most obvious paths out of
    the glade run due north and southwest, but it looks like there might also be
    a way through the trees to the east." 
    north = leafyPath
    southwest = deadEndPath
    east = darkPath
    regions = [countryside]
;

+ elm: Fixture 'wych elm; giant; tree'
    "There's something strangely bewitching about it.<.reveal wych> "
;

deadEndPath: Room 'Dead End' 'dead end'
    "The path from the northeast gets narrower and narrower until it finally
    peters out into a dead end, wholly hemmed in by the surrounding trees. "
    northeast = glade
    regions = [countryside]
;
    
darkPath: Room 'Dark Path' 'dark path'
    "The trees are so close together on either side of this path, that their
    overhanging branches form a canopy overhead, shutting out the sun and the
    sky. From the occasional glimpses of sunlight overhead you nevertheless
    judge that the path gradually bends round from west to northeast. "
    west = glade
    northeast = junction
;


overgrownTrack: Room 'Overgrown Track' 'overgrown track; narrow windy'
    "The going is quite tricky on this overgrown track, and made doubly so by
    the fact that it's both narrow and windy. Broadly speaking, and so far as
    you can tell, its meanderings result it roughly bending round from southwest
    to north. "
    
    southwest = clearing
    north = junction
    
    regions = [countryside]
;

junction: Room 'Junction of Paths' 'path junction; of[prep]; paths'
    "None of the paths leading from this junction looks especially inviting;
    there's one to the north, one to the south, one to the southwest, and one to
    the east. "
    
    north = gully
    south = overgrownTrack
    east = narrowPath
    southwest = darkPath
    
    regions = [countryside]
;
    
gully: Room 'Gully' 'gully'
    "This narrow gully runs along the east side of a steep hill -- to steep to
    climb -- following the foot of the hill round from the south to the
    northeast. "
    
    south = junction
    northeast = foothill
    regions = [countryside]
;

foothill: Room 'Foothills' 'foothills'
    "The hill immediately to the east is far too steep to climb. A gully lies
    off to the southwest, but otherwise there's mostly scrubland round about. "
    
    
    southwest = gully
    north = scrubland
    
    east = "The hill is too steep to climb. "
    
    west() { "The scrubland to the west doesn't look very inviting, and after a
        few tentative steps you decide to turn back. "; }
       
    regions = [countryside]
;

