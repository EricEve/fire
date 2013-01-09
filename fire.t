#charset "us-ascii"
#include <tads.h>

#include "advlite.h"

versionInfo: GameID
    IFID = '0D9D2F69-90D5-4BDA-A21F-5B64C878D0AB'
    name = 'Fire!'
    byline = 'by Eric Eve'
    htmlByline = 'by <a href="mailto:eric.eve@hmc.ox.ac.uk">
                  Eric Eve</a>'
    version = '1'
    authorEmail = 'Eric Eve <eric.eve@hmc.ox.ac.uk>'
    desc = 'A test game for the adv3lite library.'
    htmlDesc = 'A test game for the adv3lite library.'
    
    showAbout()
    {
        aboutMenu.display();
        
        "This is a demonstration/test game for the advlite library. It should
        be possible to reach a winning solution using a basic subset of common
        IF commands.<.p>";
    }
    
    showCredit()
    {
        "Fire! by Eric Eve\b
        adv3Lite library by Eric Eve with substantial chunks borrowed from the
        Mercury and adv3 libraries by Mike Roberts. ";               
    }
;

CustomVocab
    verbParams =
    [
        'yell/yells/yelled',
        'fight/fights/fought',
        'break/breaks/broke/broken'
    ]   
;

gameMain: GameMainDef
    initialPlayerChar = me
    
    allVerbsAllowAll = nil
    
    showIntro()
    {       
        
        cls();
        new OneTimePromptDaemon(self, &daemon); 
//        "\^<< list of [] is >>  wrong.\b";       
//        "\^<<makeListStr(hall.contents)>> {prev} {is} here.\b";
        
        george.startFollowing;
                
        "<b><font color='red'>FIRE!</font></b>  You woke up just now, choking
            from the smoke that was already starting to fill your bedroom,
            threw something on and hurried downstairs -- narrowly missing
            tripping over the beach ball so thoughtgfully left on the landing
            by your <i>dear</i> nephew Jason -- you <i>knew</i> having him to
            stay yesterday would be trouble -- perhaps he's even responsible
            for the fire (not that he's around any more to blame -- that's one
            less thing to worry about anyway).\b
            So, here you are, in the hall, all ready to dash out of the house
            before it burns down around you. There's just one problem: in your
            hurry to get downstairs you left your front door key in your
            bedroom.<.p>";
    }
    
    daemon() 
    {
        "<.p>But then another thought occurs to you: there's always the back
        door...";
    }
        
    
    paraBrksBtwnSubcontents = nil
//    useParentheticalListing = true
    
    storeWholeObjectTable = true
    
    setAboutBox()
    {
        "<ABOUTBOX><CENTER><FONT size=+2 color=red><b><<versionInfo.name>>
        </b></FONT>\b
         <<versionInfo.byline>>\b
        Version <<versionInfo.version>></CENTER></ABOUTBOX>";
    }
;
//
//Doer 'examine me'
//    exec(curCmd)
//    {
//        "Don't be so narcissistic!<.p>";
//    }
//    
//    where = downstairs
//;
//
//Doer 'go north'
//    exec(curCmd)
//    {
//        "The blue ball doesn't like going north. ";
//    }
//
//    when = (blueBall.isIn(me))
//    during = kitchenVisit
//    direction = northDir
//;
//
//kitchenVisit: Scene
//    startsWhen = (me.isIn(kitchen))
//    
//    endsWhen = (me.isIn(study))
//    
//    whenStarting = "kitchenVisit starting"
//    whenEnding = "kitchenVisit ending"
//;
//    

Doer 'go dir'
    exec(curCmd)
    {
        "Shipboard directions have no meaning in this game. ";
    }
    direction = [portDir, starboardDir, foreDir, aftDir]
;

InitObject
    execute()
    {
        new Daemon(saucepan, &temperatureDaemon, 1);
//        hall.setDestInfo(downDir, nil);
    }
;

//Doer 'jump'
//    execAction(c) { travel(northDir); }
//;

//Doer 'undo'
//    exec(c)
//    {
//        "Sorry, you can't undo right now. ";
//    }
//    
//    during = hallucination
//;
//

//Doer 'take redBall'
//    exec(c)
//    {
//        "The red ball doesn't want to be taken today. ";
//    }
//;
downstairs: Region
    regions = indoors
;

upstairs: Region
    regions = indoors
;

indoors: Region
    /* The pc is presumably familiar with the layout of his own house */
    familiar = true
;

outdoors: Region
   
;

class GoldCoin: Thing 'gold coin;;dubloon'
;

hall: Room, ShuffledEventList 'Hall' 'hall'   
    "<<one of>>At least the fire hasn't reached the ground floor yet. The hall
    is still blessedly clear of smoke, though you can see the smoke billowing
    around at the top of the stairs you've just come down. The front door
    leading out to the safety of the drive is just a few paces to the west -- if
    only you'd remembered that key! Otherwise all seems normal: \v<<or>>At a
    less troubled time you'd feel quite proud of this hall. A fine oak staircase
    sweeps up to the floor above, matching the solid front door that stands just
    to the west. <<stopping>>The pictures you bought last year look totally
    oblivious of the flames that might engulf them, and since so far the fire
    seems confined to the top floor there's nothing blocking your path north to
    the lounge, east to the kitchen, or south to the study.  "
    
    south = study
    north = lounge
    east = kitchen
    up = landing
    west = frontDoor
    out asExit(west)
    
    nornoreast 
    { 
        "That's a bit too oblique for this game. ";
        setDestInfo(nornoreastDir, nil);
    }
    
//    down { "You lack burrowing equipment. "; }
    
    roomDaemon  { doScript; }
    
    eventList = 
    [
        'Wisps of smoke drift down the stairs. ',
        
        'You momentarily catch sight of the smoke billowing at the top of the
        staircase. ',
        
        'There\'s an ominous creak upstairs. ',
        
        'You fancy you feel a wave of hot air gush about your face. '
    ]
    
    regions = downstairs
    
    listenDesc = "There's a disturbing crackling of flames somewhere upstairs. "
    
//    roomBeforeAction()
//    {
//        if(gActionIs(Jump))
//        {
//            "Better not, you might bang your head!";
//            exit;
//        }
//    }
    
//    roomAfterAction()
//    {
//        if(gActionIs(Jump))
//            "You bang your head on the ceiling. ";
//    }
//    afterAction()
//    {
//        if(gActionList.indexOf(redBall) != nil)
//            "You've just done something to the red ball. ";
//    }
    
;

+ GoldCoin;
+ GoldCoin;
+ GoldCoin;

+ me: Thing 'me;; you yourself myself'   
    "You look as bedraggled as you feel. "
    isListed  = nil
    isFixed = true
    name = 'you'
    proper = true
    ownsContents = true
    person = 2
    isHim = true
    contType = Carrier
    
//    bulkCapacity = 10
    
;

++ blueBall: Thing 'blue ball; large beach; beachball'
    "It's a large blue beach ball. "  
    vocabPlural = 'balls'   
    bulk = 5
        
//    beforeAction()
//    {
//        if(gActionIs(Take) && gDobj == redBall)
//            "The blue ball really doesn't like that!<.p>";
//    }
    
     sightSize = large
;

+ redBall: Thing 'red ball; small cricket'
    "It's a small red cricket ball. "
    vocabPlural = 'balls'
    
    
    initSpecialDesc = "A small red ball lies abandoned on the ground; no doubt
        something else Jason forgot to take with him. "
            
    bulk = 2
    
    allowPushTravel = true
    
    remoteDesc(pov) { "From here it's just a small red dot. "; }
    
;

+ frontDoor: Door 'front door; solid oak' 
    "It's a solid oak front door, strong enough to resist a siege. "
    
    otherSide = frontDoorOutside
    lockability = lockableWithKey
    isLocked = true
    
;

+ box: Booth 'big wooden box'
    isOpenable = true
    isOpen = nil
    roomTitle = 'Inside the Big Wooden Box'
    
    interiorDesc = "From inside, all you can see are the plain wooden walls of
        the box. "
    
    allowReachOut(obj) { return nil; }
    autoGetOutToReach = nil
;

+ Thing 'pictures;bland old;landscapes'
    "They're just some bland old landscapes you picked up in a charity shop. "
    
    isDecoration = true
    
    plural = true
    
    dobjFor(Examine)
    {
        action()
        {
            inherited;
            new SenseDaemon(self, &doFuse, 1); 
        }
    }
    
    
;

/* A do-it-yourself staircase */

+ Thing 'stairs; fine oak; flight staircase' 
    isFixed = true
    plural = true
   
    dobjFor(Climb)
    {
        verify() { }
        action()
        {
            "You climb the stairs up to the landing.<.p>";
            landing.travelVia(gActor);
        }
    }
    
    dobjFor(ClimbUp) asDobjFor(Climb)
    
;

+ NumberedDial 'dial'
    "It can be set to any number between 0 and 100; it's currently set to
    <<curSetting>>. "
    
    curSetting = '0'
    
    validSettings = ['off', 'slow', 'fast']
;

drive: Room 'Front Drive' 'front drive'
    "The front drive sweeps round from the northwest and comes to an end just in
    front of the house, which stands directly to the east. A narrow path runs
    round the side of the house to the southeast. "
    
    east = frontDoorOutside
    southeast = sidePath
    
    northwest()
    {
        "You stride off down the drive to safety. ";
        finishGameMsg(ftVictory, [finishOptionUndo]);
    }
    
    regions = outdoors
;

+ frontDoorOutside: Door 'front door' 
    
    otherSide = frontDoor
    lockability = lockableWithKey
    isLocked = true
;

+ Fixture 'house'
    
    dobjFor(Enter)
    {
        remap = frontDoorOutside
    }
    
;

study: Room 'Study' 'study'   
    "This is your favourite room in the whole house, where you do your best
    work, think your best thoughts, and read your best books. The way out is to
    the north."
    
    north = hall
    out asExit(north)
    
    west = "Unfortunately you can't get the window open. "
    
    regions = downstairs
    
//    roomContentsLister = new CustomRoomLister('\^', suffixMethod: 
//                                              method (lst, pl, irName) 
//        {" <<if pl>>are<<else>>is<<end>> lying on the floor. ";})
;


+ desk: Thing 'desk; fine old'
    "It's a fine old desk with a single drawer. "
    
    specialDesc = "A fine old desk stands in the middle of the room. "
//    specialDesc = "A fine old desk stands in the middle of the room<< if
//          listableContents.length > 0 >>, bearing 
//        <<list of listableContents>><<end>>. <<if deskDrawer.isOpen &&
//          deskDrawer.listableContents.length > 0>> Its drawer is open and
//        contains <<list of deskDrawer.listableContents>>. "
//    
    isFixed = true
    cannotTakeMsg = 'The desk is too heavy for one person to move around. '
        
    contType = On
    
    remapIn = deskDrawer
    
    globalParamName = 'desk'
;

++ redBox: Thing 'red box; small'
    "It's a smallish box you keep odds and ends in. "
    
    isOpenable = true
    isOpen = nil
    isLocked = true
    lockability = lockableWithKey
    contType = In
    
    bulk = 3
    bulkCapacity = 3
    
    lockedMsg = '\^<<theNameIs>> locked; you keep it that way to stop thieving
        little hands pinching your odds and ends. '
    
   
;

+++ battery: Thing 'battery' 
    bulk = 1
    achievement: Achievement { +1 "finding the battery" }
    
    dobjFor(Take)
    {
        action()
        {
            inherited;
            achievement.awardPointsOnce();
        }
    }
;

++ deskDrawer: Thing 'drawer; desk' 
    
    
    contType = In
    isOpenable = true
    isOpen = nil
    isFixed = true
    
    bulkCapacity = 6
    maxSingleBulk = 3
;

+++ brownFile: Thing 'brown file; large brown; manuscript'
    "The file contains the manuscript of an exceedingly boring book a colleague
    sent you to read so you can offer your comments on it. Frankly if it
    perished in the flames that threaten to engulf your house you wouldn't
    regard it as much of a loss. "
    
    hiddenUnder = [silverKey]
    autoTakeOnLookUnder = true
    
    dobjFor(Open) asDobjFor(Read)
    
    readDesc = "Flicking through the file for ten seconds is enough to remind
        you why this rubbish would be best consigned to the flames. "
    
    isListed = true
      
;



+ Window
;

silverKey: Key 'silver key; small'
    "It's very small. "
    actualLockList = [redBox]
    plausibleLockList = [redBox]
    bulk = 1    
    vocabPlural = 'keys'
;


kitchen: Room 'Kitchen' 'kitchen'
    "This kitchen is equipped much as you'd expect, with, for example, a sink
    over by the window, a large table in the middle of the room, and an oven
    over by the back door to the east, not far from the fridge. The other exits
    are west to the hall, north to the dining-room and down to the cellar. "
    
    north = diningRoom
    west = hall
    down = cellar
    east = backDoor
    
    regions = downstairs
;

+ backDoor: Door 'back door' 
    "It's a solid door -- all the outside doors in this house are solid, you
    made sure of that to make the place burglar-proof. <<unless
      backDoorKey.isIn(hook)>> Normally the back door key should be hanging on
    the hook right next to it, but it's not there now<<first time>>, maybe
    that's something else Jason moved<<only>>.<<end>>"
    otherSide = backDoorOutside
    
    lockability = lockableWithKey
    isLocked = true
    
;

+ hook: Thing 'hook' 
    isFixed = true
    objInPrep = 'on'
    contType = On
    bulkCapacity = 1
;


+ kitchenTable: Thing 'table; battered old kitchen'
    "The table is a battered old thing with a single drawer. "
    isFixed = true
    isListed = nil
    isBoardable = true
    contType = On
    remapIn = kitchenDrawer
    canPutUnderMe = true
    
//    checkReach(actor) { "The table is out of reach. "; }
;

++ glassBox: OpenableContainer 'glass box'
    
    isTransparent = true
;

++ kitchenDrawer: Thing 'drawer' 
    
    contType = In
    objInPrep = 'in'
    isFixed = true
    isListed = nil
    isOpenable = true
   
;

+++ torch: Thing 'large black torch;;flashlight' 
    "It's a large black torch, which can be opened at one end to insert a
    battery. "
    
    isSwitchable = true
    isLightable = true
    isOn = nil
    isListed = true
    contType = In
    
    bulkCapacity = 1
    isOpenable = true
    
    
    makeOn(stat)
    {
        inherited(stat);
        isLit = stat;
        if(stat)
            achievement.awardPointsOnce();
    }
    
    dobjFor(SwitchOn)
    {
        check()
        {
            if(!battery.isIn(self))
                "Nothing happens; probably because the torch needs a battery. ";
            else if(isOpen)
                "You probably have to close the torch for the battery to make an
                electrical contact. ";
        }        
    }
    
    dobjFor(Open)
    {
        action()
        {
            inherited;
            if(isOn)
            {
                "\nThe torch goes out.<.p>";
                makeOn(nil);
            }
        }
    }
    
    dobjFor(Light) asDobjFor(SwitchOn)
    dobjFor(Extinguish) asDobjFor(SwitchOff)
    
    achievement: Achievement { +2 "getting the torch to work" }
;


+ kitchenSink: Thing 'sink; kitchen large stainless steel' 
    "It's a large stainless steel sink with a single tap. "
    
    contType = In
    
    isFixed = true
//    isOpen = true
    bulkCapacity = 30
    
    iobjFor(PutIn)
    {
        check()
        {
            inherited();
            if(kitchenTap.isOn && gDobj is in (battery, torch, brownFile))
            {
                "Putting {the dobj/him} in the sink while the tap is running
                might not do it much good. ";
            }
                
        }
        
    }
    
    notifyInsert(obj)
    {
        if(obj == blanket && kitchenTap.isOn)
        {
            blanket.makeWetFuse();
            reportAfter('The running water at once soaks the blanket. ');
        }
    }
;
    
+ kitchenTap: Thing 'tap;silver;faucet'
    "It's a silver coloured tap of the kind you can turn on and off. "
    iobjFor(PutUnder) remapTo(PutIn, DirectObject, kitchenSink)
    isFixed = true
    isSwitchable = true
    
    stateDesc = (isOn ? 'A steady stream of water flows from the tap. ' : 'The
        tap is currently turned off. ')
    
    makeOn(stat)
    {
        local rep;
        inherited(stat);
        if(stat)
        {
            water.moveInto(kitchen);
            rep = 'Water starts gushing from the tap';
            if(blanket.isIn(kitchenSink))
            {    
                rep += ', soaking the blanket in the process';
                blanket.makeWet();              
            }            
            rep += '. ';
            if(bucket.isIn(kitchenSink))
            {
                if(blanket.isIn(bucket))
                    rep += 'The blanket stems the flow of water from the bucket
                        only for an few seconds before the water leaks out of
                        the hole in the bottom of the bucket. ';
                else
                    rep += 'The water runs into the bucket only to run straight
                        out of the hole in its bottom. ';             
            }
            reportAfter(rep);
        }
        else
        {
            reportAfter('The water stops flowing from the tap and rapidly drains
                away from the sink. ');
            water.moveInto(nil);
        }
        
        
    }
    
    dobjFor(SwitchOn)
    {
        check()
        {
            local lst = [];
            foreach (local cur in kitchenSink.contents)
            {
                if(cur is in (torch, battery, brownFile))
                    lst += cur;
            }
            
            if(lst.length > 0)
                "Turning on the tap while <<makeListStr(lst, &theName)>> <<if
                  lst.length > 1>>are<<else>>is<<end>> in the sink might not do
                <<if lst.length > 1>>them<<else>>it<<end>> too much good. ";
        }
    }
    
    dobjFor(Turn)
    {
        remap()
        {
            if(isOn)
                return [SwitchOff, self];
            else
                return [SwitchOn, self];
        }
    }
    
    
;

    




+ cooker: Thing 'cooker;blackened;oven stove top'
    "Normally, you keep it in pretty good shape (or your cleaner does) but right
    now it's looking suspiciously blackened, especially round the top. "    
    
    isFixed = true
    isSwitchable = true
    isOn = true
    
    smellDesc = "There's a distinct smell of burning from the cooker. "
    
    remapIn: SubComponent
    {
        isOpenable = true
        bulkCapacity = 6
    }
    
    remapOn: SubComponent  {  }
;



++ saucepan: Thing 'saucepan;;pan'
    "It's absolutely blackened. It was obviously left on the stove too long --
    perhaps that's what started the fire. "
   
    subLocation = &remapOn
    contType = In
    
    temperature = 100
    
    temperatureDaemon()
    {
        if(location == cooker.remapOn && cooker.isOn && temperature < 100)
            temperature++;
        
        if((location != cooker.remapOn || !cooker.isOn) && temperature > 15)
            temperature--;
    }
    
    checkReach(obj)
    {
        if(temperature > 70)
        {
            "The saucepan is <<if temperature > 90>>far <<else if temperature
            < 80>> just<<end>> too hot to touch!<.p>";            
        }        
    }
    
    cannotBurnMsg = 'The saucepan\'s quite burnt enough already! '
;




+ Odor 'smell of burning; acrid distinct'
    "It smells quite acrid. "   
;
    

+ Thing 'ceiling;scorched;mark'
    "There's a scorched mark, a <i>badly</i> scorched mark, just above the stove.
    "
    
    isDecoration = true
    notImportantMsg = 'The ceiling is out of reach. '
;

+ Window
;

+ fridge: SimpleAttachable 'fridge; large white; refrigerator door'
    "It's a large, white floor-standing refrigerator. "
    remapIn: SubComponent { isOpenable = true }
    allowableAttachments = [magnet]
    isFixed = true
    isListed = nil
;

++ magnet: SimpleAttachable 'small magnet; red maple; leaf'
    "It's red and shaped like a maple-leaf. You must have picked it up on your
    last trip to Canada. "
    attachedTo = fridge
    
    allowableAttachments = [backDoorKey]
;

++ cheese: Thing 'piece of cheese; strong; cheddar'
    
    isEdible = true
    tasteDesc = "It's a strong cheddar. "
    smellDesc = "The cheese smells quite strong. "
    subLocation = &remapIn
    
    isProminentSmell = true
;

water: Thing 'water; flowing'
    "The water flows steadily from the tap. "
    article = 'some'
    isFixed = true
    cannotTakeMsg = 'The water simply runs through your fingers. '
    
    dobjFor(SwitchOff)
    {
        remap = kitchenTap
    }
    
    dobjFor(Drink)
    {
        verify() {}
        action()
        {
            "You catch some of the water in the palm of your cupped hand and
            scoop it into your mouth. ";
        }
    }
   
;

cellar: Room 'Cellar' 'cellar'
    "It's not a pleasant place at the best of times, dark, dank and smelly, with
    piles of old junk strewn all over the place waiting for you to find time to
    sort them out (which you probably never will). "
    
    isLit = nil
    darkName = 'Cellar (in the dark)'
    darkDesc = "It's too dark to see anything down here, but you could just
        about find your way back up to the kitchen. "
    up = kitchen
    
    regions = downstairs
;

+ blanket: Thing 'blanket; worn old grey '
    "The old blanket may have been blue once, but it's gone grey with age. "
    isListed = true
    isWet = nil
    isWearable = true
    initSpecialDesc = "An old blanket covers a further pile of junk over in the
        corner. "
    
    hiddenUnder = [bucket]
    
    stateDesc = (isWet ? ' The blanket is now quite wet. ' : '')

    makeWet()
    {        
        if(!isWet)
        {
            name = 'wet blanket';
//            vocabWords = 'soaking wet ' + vocabWords;
            vocab = 'wet ' + vocab;
            initVocab();
            isWet = true;
        }
    }
    
    makeWetFuse() { new Fuse(self, &makeWet, 0); }
    
    dobjFor(PutIn)
    {
        
        report()
        {
            inherited;
            if(isWet)
                name = 'wet blanket';
        }
    }
;

+ junk: Thing 'junk; old; pile detritus piles'
    "The half-forgotten detritus of years, piled up waiting the time that will
    never come when you feel like sorting it all out. "
    isDecoration = true
    isPlural = true
    notImportantMsg = 'You really don\'t have time to mess around with that old
        junk right now. '
    
    decorationActions = [Examine, LookIn]
;


/* 
 *   This should now  be set up to match GO THROUGH JUNK but not WALK THROUGH
 *   JUNK
 */

Doer 'go through junk'
    
    strict = true
    
    exec(curCmd)
    {
        redirect(curCmd, LookIn);
    }
;

bucket: Thing 'rusty bucket; old; hole bottom'
    "It's a rusty old bucket which, on closer inspection, turns out to have a
    hole in the bottom. "
    
    objInPrep = 'in'
    contType = In
;    

lounge: Room 'Lounge' 'lounge'
    "The lounge is unusually bare right now, since you had it redecorated last
    month and you haven't got round to having the furniture put back. Exits lead
    south and east. "
    south = hall
    east = diningRoom
    regions = downstairs
;


+ Window
;

+ rug: Platform 'persian rug; old'
    "It's old and worn. "
    specialDesc = "An old Persian rug lies in the middle of the floor. "
    useSpecialDesc = (!moved)
    
    bulk = 10
    
    hiddenUnder = [looseFloorboard]
    
    
;

looseFloorboard: Thing 'loose floorboard'
    hiddenUnder = [hole]
    bulk = 2
    
    putBack()
    {
        hiddenUnder += hole;
        moveInto(lounge);
        "You put the loose floorboard back in place over the hole. ";
    }
    
    useSpecialDesc = (hiddenUnder.indexOf(hole) != nil)
    
    specialDesc = "There's a loose floorboard in the middle of the floor. "
;

hole: Fixture 'hole'
    "It's a small rectangular hole in the floor, too small to get your hand in
    very far. "
    
    specialDesc = "There's a small hole in the floor. "
    
    iobjFor(PutIn)
    {
        verify() { }
        
        check()
        {
            if(gDobj.bulk > 2)
                "{The subj dobj} {is} too big to fit in the hole. ";
        }     
    }
    
    iobjFor(PutOn)
    {
        verify() {}
        check()
        {
            if(gDobj != looseFloorboard)
                "{The subj dobj} {does}n't really fit there. ";
        }
    }
    
    
    notifyInsert(obj)
    {
        switch(obj)
        {
        case looseFloorboard:
            looseFloorboard.putBack();
            break;
        case magnet:
            if(!backDoorKey.moved)
            {
                "There's a sudden ping and a slight jolt as something
                attaches itself to the magnet. ";
                backDoorKey.moveInto(magnet);
                backDoorKey.moved = true;
                backDoorKey.attachedTo = magnet;
            }
            else
                "The magnet fails to attract anything else inside the hole.
                ";
            break;
        default:
            "You don't want to risk losing {the dobj} in the hole. ";
            
        }
        exit;
    }
;


diningRoom: Room 'Dining Room' 'dining room'
    "It's a decent-sized room, large enough to entertain a dozen people at the
    table without feeling at all crowded. The kitchen lies conveniently to the
    south and the lounge just as conveniently to the west. "
    
    south = kitchen
    west = lounge
    regions = downstairs
;

+ diningCabinet: Thing 'glass-fronted cabinet;large glass fronted'

    isFixed = true
    isOpenable = true
    contType = In
    isTransparent = true
    
    specialDesc = "A large glass-fronted cabinet stands against the wall. "
    
    hiddenBehind = [napkin, biro]
;
    
++ silverDish: Thing 'silver dish'
    
    contType = On
    bulk = 4
    bulkCapacity = 4
;

+ Window
;

napkin: Thing 'red paper napkin'
;

biro: Thing 'broken biro'
;
   
landing: Room 'Landing' 'landing'
    "The smoke is already becoming so thick here that it's hard to see much.
    Your bedroom lies to the north -- if you can make your way through the
    smoke. Most of the other upstairs rooms are down the passage the other way,
    to the south, but the worst of the smoke seems to be coming from there. "
    
    down = landingStairs
    
    north: TravelConnector
    {
        destination = bedroom
        
        travelDesc = "You manage to force your way through the smoke, coughing
            and choking as you go. ";
        
        canTravelerPass(actor)
        {
            return blanket.wornBy == actor && blanket.isWet;
        }
        
        explainTravelBarrier(actor)
        {
            if(blanket.wornBy == actor)
                "You take a few steps down the corridor but the smoke forces you
                back as the blanket starts to get singed. ";
            else
                "The smoke is too thick; you find yourself coughing and choking
                after the first step and are forced to retreat. ";
        }
    }
    
    
    south  { "The smoke is too thick that way; you almost choke to death
        with the first step south you take. Well, it's not as if there's
        anything down there you really need all that much right now. "; }
    
    regions = upstairs
;

/* A pre-built staircase from extras.t */

+ landingStairs: StairwayDown 'stairs;fine oak;flight staircase'
    
    travelDesc = "You retreat back down to the hall. "
    destination = hall
;

bedroom: Room 'Bedroom' 'bedroom'
    "Your bedroom is fast filling up with smoke, but so far as you can see
    nothing's damaged yet. Your bed is just as you left it, as is your little
    bedside cabinet. The only way out is to the south, opposite the
    full-length mirror. "
    
     south = landing
    
    regions = upstairs
//    vocabWords = 'bedroom'
;

+ bed: Thing 'bed' 
    "It looks rather messy as you had to get out of it in something of a hurry
    just now. "
    
    isFixed = true
    isBoardable = true
    
    objInPrep = 'on'
    contType = On
    
    cannotTakeMsg = 'The bed is far too heavy for you to start trying to move it
        around right now. '
    
    dobjFor(Enter) asDobjFor(Board)
;

+ bedsideCabinet: Thing  'cabinet; small square white bedside '
    "It's a small, square, white cabinet with a single drawer. "
    
    isFixed = true
    contType = On
    objInPrep = 'on'
    remapIn = bedsideDrawer           
    
;


++ bedsideDrawer: Thing 'drawer' 
    
    isFixed = true
    isOpenable = true
    objInPrep = 'in'
    contType = In
            
;

+++ strongBox: Thing 'small strong box; black metal'
    "It's a small black metal box, stronger than in looks, in which you keep
    certain valuables. <<if !brassKey.moved>> You remember you put your front
    door key in it just before you went to bed, just for safekeeping.<<end>> The
    box has three small dials which need to be set to the correct combination to
    unlock it. "
    
    remapIn: SubComponent
    {
        lockability = indirectLockable
        isLocked = true
        isOpen = nil
        isOpenable = true
        
        indirectLockableMsg = 'To unlock it you need the combination. '
    }    
    
    afterAction()
    {
        if(gActionIn(TurnTo, SetTo) && gDobj.ofKind(BoxDial))
        {
            if(dials.indexWhich({d: !d.correctlySet} ) == nil)
            {
                remapIn.makeLocked(nil);
                "You hear a soft click from the box. ";
            }
            else
                remapIn.makeLocked(true);
        }
    }
    
    dials = [boxDial1, boxDial2, boxDial3]
;
    
++++ boxDial1: BoxDial 'first dial'
    correctSetting = 1
;

++++ boxDial2: BoxDial 'second dial'
    correctSetting = 2
;

++++ boxDial3: BoxDial 'third dial'
    correctSetting = 3
;

++++ brassKey: Key 'brass key; medium sized'    
    "It's just a medium sized brass key, typical of the sort used to lock and
    unlock doors. "
    plausibleLockList = [frontDoor, frontDoorOutside, backDoor, backDoorOutside]
    actualLockList = [frontDoor, frontDoorOutside]
    subLocation = &remapIn
;

+ mirror: Fixture 'full-length mirror;full length plain; reflection; it'
    "It's a plain enough mirror, but it's useful for dressing and suchlike. "
    dobjFor(LookIn)
    {
        action()
        {
            "Looking in the mirror you <<if meadow.visited>> simply see your own
            reflection and part of the smoke-filled bedroom behind you<<else>>
            see something more than a little surprising: your own reflection is
            perfect, but instead of seeing your bedroom behind you, you see a
            meadow bathed in sunshine<<end>>. ";
        }
    }
    
    dobjFor(Enter)
    {
        verify() 
        { 
            if(meadow.visited)
                inherited;
            
            logicalRank(70); 
        }
        action()
        {
            george.stopFollowing;
            local lst = me.contents;
            foreach(local cur in lst)
                cur.moveInto(bedroom);
            
            "To your surprise you find you can step into the mirror with ease.
            Just what is going on here? Anyway, after a moment of utter
            disorientation you find yourself blinking in the sunlight. You seem
            to have been translated not only in space but in time...\b";
            meadow.travelVia(gActor);
        }
    }
    
    dobjFor(GoThrough) asDobjFor(Enter)
    
    cannotBoardMsg = 'It seems you can\'t do that again; now it\'s just an
        ordinary mirror. '
;

class BoxDial: NumberedDial    
    desc = "It's currently turned to <<curSetting>>. "
    correctSetting = 0
    correctlySet = (toInteger(curSetting) == correctSetting)
    maxSetting = 9
    minSetting = 0
    curSetting = '0'
;
    

backYard: Room 'Back Yard' 'back yard'
    "It's very dark out here. The back door stands <<if backDoorOutside.isOpen>>
    open <<else>> closed <<end>> just to the west, and you're aware that the
    bulk of your garden lies off to the east, though you can't see any of it. A
    narrow path snakes round the side of the house to the southwest. "
   
    darkDesc = "Despite the light seeping out through the back door just to the
        west, it is virtually pitch black out here. "
        
    darkName = 'Back Yard (in near total darkness)'
    west = backDoorOutside
    southwest = sidePath
    east { "Your garden lies that way, but it's so dark you'd rather not venture
        into it right now. "; }
    
    
    regions = outdoors
    isLit = nil
;

+ backDoorOutside: Door 'back door' 
     otherSide = backDoor
    isLocked = true
;


sidePath: Room 'Path Round Side of House' 'path'
    "This narrow path runs round the side of the house from the main drive to
    the northwest to the back yard to the northeast. "
    
    darkName = 'Narrow Path (in the dark)'
    darkDesc = "You can see little on this dark, narrow path apart from a faint
        glow from the northwest. "
    
    northwest = drive
    northeast = backYard
    
    isLit = nil
    
    regions = outdoors
;

backDoorKey: SimpleAttachable, Key 'dull metal key; iron' 
    
    vocabPlural = 'keys'
    plausibleLockList = [frontDoor, frontDoorOutside, backDoor, backDoorOutside]
    actualLockList = [backDoor, backDoorOutside]
    
;

moon: MultiLoc, Thing 'moon; bright full'
    "It's a bright full moon. "
    isDecoration = true
    notImportantMsg = 'The moon is far too far away'
    locationList = [outdoors]
    
    visibleInDark = true
;

/* Cheap room parts */

sky: MultiLoc, Distant 'sky; dark night; stars'
    "The dark night sky is full of stars. "
    locationList = [outdoors]
    
    visibleInDark = true
;

ground: MultiLoc, Decoration 'ground'
    
    locationList = [outdoors]
    
    visibleInDark = true
;


floor: MultiLoc, Decoration 'floor;;ground'
    
    locationList = [indoors]
;

MultiLoc, Decoration 'ceiling'
 
    locationList = [indoors]
    exceptions = [kitchen]
;

class Window: Thing 'window;toughened;glass'
    "The window is closed, and gazes out onto the blackness of the night. "
    isFixed = true
    isOpenable = true
    lockability = lockableWithKey
    isLocked = true
    
    lockedMsg = '{The subj dobj} {is} locked<<one of>>. All the windows in this
        house are kept for security purposes (your insurers insist on it),
        but<<or>> and <<stopping>> you can never remember where you keep those
        fiddly little keys. '
    
    shouldNotBreakMsg = 'It\'s made of toughened glass -- a precaution against
        burglary. So far it has proved very effective at keeping burglars out
        but it seems to be equally effective at keeping you in. '
    
    shouldNotAttackMsg = (shouldNotBreakMsg)
    
    nothingThroughMsg = 'All you can see through the window is the blackness of
        the night outside. '
    
    iobjFor(ThrowAt)
    {
        action()
        {
            gDobj.moveInto(getOutermostRoom);
            "{The subj dobj} {bounces} off the toughened glass and {lands} on
            the ground. ";
        }
    }
    
;

nowhere: Room 'Nowhere' 'nowhere'
;

blueBook: Consultable 'blue book; useless trusty of;dictionary information' @desk
    "It's your trusty dictionary of useless information. "
    
    readDesc = "It's not the sort of book you'd want to read from cover to
        cover; it's more for looking things up in. "
;

+ ConsultTopic @tLemons    
    "Apparently they're yellow and sour. "
;

+ ConsultTopic 'oranges'
    "They're round and juicy. "
;

+ ConsultTopic @Door
    "Doors can be opened and closed, and when open you can go through them. "
;


+ ConsultTopic '(black|red|green) blob(s){0,1}'
   "They're very blobby. "   
;

+ DefaultConsultTopic
    "You thumb through the blue book in vain for any interesting information
    on that topic. "
;


tLemons: Topic 'lemons'
;

tHappened: Topic 'it happened;did happen'
;

george: Actor 'George; tall thin; man' @hall
    "He's a tall thin man<<if listableContents.length > 0>>, currently
    carrying <<list of listableContents>><<end>>. "
    isHim = true
    actorSpecialDesc = "George is standing just across 
        <<getOutermostRoom.theName>>. "
    
    actorBeforeTravel(traveler, connector)
    {
        if(traveler == gPlayerChar)
            "<.p>George starts after you.<.p>";
    }
    
    globalParamName = 'george'
;

/* 
 *   The <.agenda fireAgenda> tag adds fireAgenda to the agendaList of George
 *   and all his DefaultAgendaTopics
 */
+ HelloTopic, StopEventList
    [
        '<q>Hello,</q> you say.\b
        <q>Hi there!</q> George replies.  ',
        
        '<q>Hello again!</q> you declare.\b
        <q>Hi,</q> says George. '
    ]
    changeToState = georgeTalking
;

+ AskTopic @redBall
    "<q>What do you know about this red ball?</q> you ask.\b
    <q>It was left there by your nephew, I believe,</q> he tells you. "
    name = 'the red ball'
;

+ AskTopic @tLemons
    "<q>Do you like lemons?</q> you ask.\b
    <q>No, they're too sour for me,</q> he complains. "
    name = 'lemons'
;


/* 
 *   The <.state georgeSulking> tag switches George's ActorState to
 *   georgeSulking.
 */
+ AskTopic @tMistress
    "<q>Why don't you tell me about your mistress?</q> you ask.\b
    George pouts. <q>Shan't!</q> he cries. <.state georgeSulking> "
    
    name = 'his mistress'
;

/* 
 *   The <.activate> tag does not actually switch to a ConvNode, because there's
 *   no such thing in this library, but it produces a similar effect by
 *   activating all topics with a convKeys of 'age-node'.
 */
+ QueryTopic 'how' @tHowOld
    "<q>How old are you?</q> you ask.\b
    <q>None of your damned business,</q> he replies. <q>Would you like someone
    asking you about your age?</q><.convnodet age-node> "
    
    /* 
     *   specifying the askMatchObj property allows George to respond to ASK
     *   GEORGE ABOUT HIS AGE in the same well as ASK GEORGE HOW OLD HE IS.
     */
    askMatchObj = tAge
    convKeys = ['george']
;

+ QueryTopic 'where' 'he was born; were you'
    "<q>Where were you born?</q> you ask.\b
    <q>London,</q> he replies flatly. "
    convKeys = ['george']
;


+ QueryTopic 'if|whether' 'he likes chocolate; you like'
    "<q>Do you like chocolate?</q> you ask.\b
    <q>Of course,</q> he replies. <q>Doesn't everyone?</q>"
;

+ SayTopic 'he looks very tall; you look'
    "<q>You look very tall,</q> you remark.\b
    <q>I'm the height I am,</q> he replies with a little shrug. "
    tellMatchObj = tHeight
    convKeys = ['george']
;

+ TellTopic @frontDoor
    "<q>What I need to open that door is the brass key,</q> you say.
    <.inform brass-key><.known brassKey> "
    name = 'the front door'
;

+ YesTopic
    "<q>Yes, sure, I wouldn't mind,</q> you reply.\b
    <q>Well, I do,</q> he grunts. "
    convKeys = ['age-node']
    isActive = nodeActive
    timesToSuggest = nil
;

+ NoTopic
    "<q>No, I suppose not,</q> you concede.\b
    <q>Well, there you are then!</q> he declares triumphantly. "
    convKeys = ['age-node']
    isActive = nodeActive
    timeToSuggest = nil
;

+ TellTopic @tYourAge
    "<q>I'm forty-three,</q> you tell him.\b
    <q>Well bully for you!</q> he declares. "
    convKeys = ['age-node']
    autoName = true
;

+ NodeContinuationTopic
    "<q>I thought I asked you a question,</q> George reminds you. "
    convKeys = ['age-node']
;
   
+ NodeEndCheck
    canEndConversation(reason)
    {
        if(reason == endConvBye)
        {
            "<q><q>Goodbye,</q> isn't an answer,</q> George complains. <q>Would
            you like someone to ask you about your age or wouldn't you?</q> ";
                              
            return blockEndConv;
        }
        
        return true;
    }
    
    convKeys = ['age-node']
;

+ DefaultAnyTopic
    "<q>Don't try to change the subject; I want to know whether you'd like
    someone asking about your age,</q> he insists. <q>Well, would you?</q>
    <.convstay> <.topics> "
    convKeys = ['age-node']
    isActive = nodeActive
;

+ YesTopic
    "<q>Yes!</q> you declare. "
    name = 'say yes'
;

+ AskTellTalkTopic @george
    
    keyTopics = ['george']
;

+ CommandTopic @Jump
    "<q>Jump!</q> you cry.\b
    <q>Very well then,</q> he agrees. "
    allowAction = true
;

+ CommandTopic @Take
    "<q>George, be a good fellow and pick up that red ball will you?</q> you
    request.\b
    <q>Very well,</q> he agrees.<.p>"
    
    allowAction = true
    matchDobj = redBall
    isActive = !redBall.isIn(george)
;

+ KissTopic
    "George shies away from you. "
;

+ HitTopic
    "<q>What did you do that for?</q> George cries. "
;

+ DefaultTellTopic
    "<q>How interesting,</q> he remarks dryly. "
;

+ DefaultGiveShowTopic
    topicResponse()
    {
        gAction.giveReport = 'George takes one look at {1} and shakes his
        head. ';
    }
;

+ DefaultCommandTopic
    "<q>George, would you <<actionPhrase>> please?</q> you ask.\b
    <q>No, I don't think I will,</q> he replies. "
;

+ DefaultAnyTopic    
    "<q>I am not programmed to respond in that area,</q> he confesses. "
;

+ DefaultTalkTopic
    "<q>I'd rather not talk about that,</q> he tells you. "
;

+ DefaultAgendaTopic
    "<q>Let's talk about something else,</q> he suggests. <.topics>"
;

+ AskForTopic
    topicResponse()
    {
//        if(matchObj != nil)
//        {
            "<q>Can I have <<matchObj.theName>>, please?</q> you ask.\b
            <q>Sure,</q> he replies, handing it to you. ";
            matchObj.moveInto(me);
//        }
    }
    
    matchTopic(top)
    {
        local obj = getActor.listableContents.indexOf(top) ? top : nil;
        if(obj != nil)
            matchObj = obj;
        return obj != nil ? matchScore : nil;        
    }
    
    matchObj = nil
    
;

+ fireAgenda: ConvAgendaItem
    isReady = inherited && getActor.curState != georgeSulking
    
    invokeItem()
    {
        isDone = true;
        "<<if invokedByActor>><q>What I want to know,</q> says George, 
        <q><<else>><q>Never mind that,</q> George interrupts you, <q>what I want 
        to know<<end>> is what you're going to do about this fire.</q> 
        <.agenda fireAgenda2>";
    }
;

+ fireAgenda2: ConvAgendaItem
    
    invokeItem()
    {
        isDone = true;
        
        "<q>Of course,</q> George muses, <q>There's really not much you can do
        about this fire except get away from it.</q> ";
    }
;

+ ByeTopic
    "<q>Goodbye,</q> you say.\b
    <q>Cheerio,</q> he replies. <q>Not that either of us is going anywhere.</q> "

;

+ DefaultQueryTopic
    "<q>I need to think about that,</q> he replies. "
;


+ georgeSulking: ActorState
    specialDesc = "George is pointedly looking away from you. "
    activateState(actor, oldState)
    {
        "George goes into a big sulk. ";
        new Fuse(self, &endSulk, 5);
    }
    
    endSulk()
    {
        "George decides to stop sulking and turns back to you. ";
        getActor.setState(nil);
    }
;

++ DefaultAnyTopic
    "George refuses to take any notice of you. "
;

+ georgeTalking: ActorState
    specialDesc = "George is watching you carefully, waiting for you to speak. "
    
    arrivingTurn() { getActor.initiateTopic(getActor.getOutermostRoom); }
;

++ InitiateTopic @lounge
    "<q>H'm,</q> says George. <q>This room is rather bare, isn't it?</q>. "
;

++ InitiateTopic @kitchen
    "<q>Ah!</q> says George. <q>Any chance of some grub?</q> "   
;

+ ActorHelloTopic
    "George coughs to get your attention. "
    changeToState = georgeTalking
;

+ ConvAgendaItem
    isReady = inherited && getActor.getOutermostRoom == study
    invokeItem()
    {
        "<q>So this is where you work, is it?</q> <<if
          greetingDisplayed>>he<<else>>George<<end>> asks. <.convnode
        study-node>";
        isDone = true;
    }
    initiallyActive = true
;

+ YesTopic
    "<q>Yes, this is where I do all my best work,</q> you reply. "
    convKeys = 'study-node'
    isActive = nodeActive
;

+ NoTopic
    "<q>No, I only pretend to work here,</q> you reply. "
    convKeys = 'study-node'
    isActive = nodeActive
;

tMistress: Topic 'his mistress; love life'
;

tHowOld: Topic 'old he is; are you'
;

tAge: Topic 'his age'
;

tYourAge: Topic '() your age'
;


tHeight: Topic 'his height'
;

tFire: Topic 'fire'
;

//CustomMessages
//    messages = [
//        Msg(cannot read, 'Don\'t be daft, there\'s obviously nothing to read
//            there. ')
//    ]
//    
//;
//    
// 
//CustomMessages
//    messages = [
//        Msg(report take, 'Snatched. | You grab {1}. '),
//        Msg(fixed in place, 'Idiot; any fool can see {the subj dobj} {is} firmly
//            nailed down. '),
//        Msg(already holding, 'In case you hadn\'t noticed, you\'re already
//            holding {the dobj}. '),
//        Msg(cannot take my container, 'Great idea. Just how do you propose to
//            pick up {the dobj} while you\'re right {1}? ')    
//           
//    ]
//;
//
//modify Thing
//    reportDobjTake() { DMsg(foo, '{1} {2}', 1+1, gDobj); }
//;

myThoughts: ThoughtManager
;

+ Thought @george
    "To be honest, you're not really sure what he's doing here. "
;

+ Thought @tFire
    "It's a wretched nuiscance. Your nephew's probably to blame for it
    somehow, but the important thing right now is just to escape from it. "
;

+ DefaultThought
    "You find your thoughts start to wander; for some reason you can't
    concentrate on that topic right now. "
;

 topHintMenu: TopHintMenu 'Hints';

+ Goal 'How do I get out of the house?'
    [
        'Well, that\'s the problem, isn\'t it? ',
        'There are two ways out -- you have to find the appropriate key. ',
        'You left the key to the front door in your bedroom. '
    ]
    openWhen = true
;
        
 aboutMenu: MenuItem 'About';
   + MenuItem 'About Adventure';
   
   ++ MenuLongTopicItem 'About the Game'
       menuContents = 'This charming piece is something I cribbed off an obscure
	     work by Crowther and Woods. '
    ;		 
   ++ MenuLongTopicItem 'Special Commands'
        menuContents = 'Under no circumstances should you use the commands
		 PLUGH and XYZZY without a special license. '   
    ;
	
   + MenuItem 'Playing TADS games';
   
   ++ MenuLongTopicItem 'Standard Commands'
      menuContents = 'Common IF commands include EXAMINE, TAKE...'
	;
	
   ++ MenuLongTopicItem 'Conversational Commands'
     menuContents = 'TADS games use a modified version of the ASK/TELL system...'
    ;        


nornoreastDir: Direction
    name = 'nornoreast'
    dirProp = &nornoreast
    sortingOrder = 1450
;

grammar directionName(nornoreast): 'nornoreast' | 'nne' : Production
    dir = nornoreastDir
;

hallucination: Scene
    startsWhen = true
    endsWhen = (redBox.isOpen || backDoorKey.moved)
    
    whenEnding()
    {
        george.stopFollowing();
        george.moveInto(nil);
        "<.p>You look round and suddenly notice that George isn't there any
        longer. Gosh, that smoke must <i>really</i> have got to you if you've
        started hallucinating a non-existent chap called George. Or maybe that
        Jason put something evil in your scotch earlier on.</p>";
    }
;


VerbRule(Grab)
    ('grab' | 'snatch') multiDobj  
    : VerbProduction
    action = Take
    verbPhrase = 'grab/grabbing (what)'
    missingQ = 'what do you want to grab'
;

VerbRule(WakeUp)
    'wake' 'up'
    : VerbProduction
    action = WakeUp
    verbPhrase = 'wake/waking up'    
    priority = 60
;

DefineIAction(WakeUp)
    execAction(cmd)
    {
        "{I}{\'m} not asleep. ";
    }
;

Doer 'wake up'         
    execAction(c)
    {
        "You wish you could wake up from this nightmare. ";
    }
    during = hallucination
;


VerbRule(Rub)
    'rub' multiDobj
    : VerbProduction
    action = Rub
    verbPhrase = 'rub/rubbing (what)'
    missingQ = 'what do you want to rub'
;
        
DefineTAction(Rub)
;

note: Thing 'note; white of[prep]; sheet piece paper writing' @me
  "It's a sheet of white paper with writing on it. "
  
  readDesc = "On the paper is written:\n <<showTextList()>> "

  textList = ['Things to do:']
  
  showTextList()
  {
     foreach(local cur in textList)
       "<<cur>>\n";
  }

  dobjFor(WriteOn)
  {
      /* We can't normally write on Things so we need to override verify() to make it possible */
      verify() { } 
      
      action()
      {
          textList += gLiteral;
          "You write <q><<gLiteral>></q> on the note. ";
      }
      
  }
  
;

VerbRule(Write)
    'write' literalDobj
    : VerbProduction
    action = Write
    verbPhrase = 'write/writing (what)'
    missingQ = 'what do you want to write'
;

DefineLiteralAction(Write)
    execAction(cmd)
    {
        "(on the note)\n";
        cmd.iobj = note;
        WriteOn.exec(cmd);
    }
;
  

InitObject
    execute()
    {
        george.addToPendingAgenda(fireAgenda);
    }
;

//Doer 'jump'
//    who = george
//    exec(c)
//    {
//        "George bounces up and down like a demented jelly on springs. ";
//    }
//;

#ifdef __DEBUG

VerbRule(Summon)
    'summon' multiDobj
    : VerbProduction
    action = Summon
    verbPhrase = 'summon/summoning (what)'
    missingQ = 'what do you want to summon'
;

DefineTAction(Summon)
    addExtraScopeItems(role) { makeScopeUniversal(); }
;

modify Thing
    dobjFor(Summon)
    {
        verify()
        {
            if(isIn(gActor.getOutermostRoom))
                illogicalNow('{The subj dobj} {is} already here. ' );
        }
        
        action()
        {
            moveInto(gActor.getOutermostRoom);
        }
        
        report()
        {
            "\^<<gActionListStr>> appears before you! ";
        }
    }
    
    handleCommand(action)
    {
        if(isOpenable && !isOpen)
        {
            "\^<<theName>> flies open! ";
            makeOpen(true);
        }
        else
            inherited(action);
    }
;

DefineIAction(Xyzzy)
    execAction(cmd)
    {
        "Your spell falls limp on the air. ";
    }
;

VerbRule(Xyzzy)
    'xyzzy'
    : VerbProduction
    action = Xyzzy
    verbPhrase = 'say/saying XYZZY'
;
#endif