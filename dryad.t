#charset "us-ascii"
#include <tads.h>

#include "advlite.h"


dryad: Actor 'dryad; beautiful strange; nymph spirit woman girl; her'
    "She looks beautiful but strange, with a narrow, elfin face, green-tinged
    skin and and very long hair the colour of autumn leaves. "    
    
    allowKiss = true
;

+ Fixture '() hair; long brown wavy russet'
    "It's very long -- at least down to her waist -- very thick too and wavy,
    and a kind of mottled russet colour, like a riot of autumn leaves. "
    
    cannotTakeMsg = 'The dryad\'s hair is quite firmly attached to her. '
    
    feelDesc = "It feels as thick as it looks, but a bit coarse-textured. It's
        quite pleasant to touch but not especially soft.\bThe dryad cocks an
        eyebrow at you as you finger her hair, but she doesn't appear to
        object. "
;

+ dryadTalkingState: ActorState
    specialDesc = "The dryad is standing just in front of the wych-elm, eyeing
        you with an ambiguous elfin smile. "
    
   
;

++ KissTopic
    "She laughs and pushes you gently away. <q>Tsk! Tsk!</q> she chides you with
    a good-natured grin. <q>If you try making love to me you might get
    splinters!</q> <.convstay> "
;


+ dryadIntroduction: ConvAgendaItem
    invokeItem()
    {
        getActor.setState(dryadTalkingState);
        
        "<q>Don't look so shocked!</q> she chides you. <q>Haven't you ever seen
        a dryad before?</q> Momentarily cocking her head to one side she goes
        on, <q>No, I suppose you haven't. Which I suppose means you're now
        wondering if I'm real, aren't you?</q> <.convnode real-1-node>";
        
        isDone = true;
    }
    
;

+ YesTopic
    "<q>Yes, I was wondering just that,</q> you confess.\b 
    <q>Of course it all depends what you mean by real,</q> she replies. <q>I
    mean, do you really know what's really real?</q> <.convnode real-2-node>"
    
    isActive = nodeActive
    convKeys = 'real-1-node'
;

+ NoTopic
    "<q>No, I wasn't wondering at all, as a matter of fact,</q> you tell her.
    <q>I <i>know</i> you can't be real!</q>\b
    <q>Can't I?</q> she retorts with a quizzical smile. <q>I can assure you I
    feel real enough to me! How do you know what's real and what isn't? Do you
    really know what's really real?</q><.convnode real-2-node> "
    
    isActive = nodeActive
    convKeys = 'real-1-node'
;

+ DefaultAnyTopic
    "The dryad interrupts your barely coherent burbling with good-natured
    amusement. <q>Lost for words?</q> she suggests. <q>Your problem is that
    you don't really understand the nature of reality. I mean, do you actually
    know what's really real?</q> <.convnode real-2-node> "

    isActive = nodeActive
    convKeys = 'real-1-node'
;

+ NodeContinuationTopic, ShuffledEventList
    [
        '<q>I thought I asked you if you know what\'s really real,</q> the dryad
        reminds you. <q>Well -- do you?</q> ',
        
        '<q>You don\'t seem too anxious to answer my question,</q> the dryad
        complains. <q>Do you actually know what\'s really real?</q>',
        
        'The dryad sighs heavily. <q>I see my question must be too hard for
        you,</q> she remarks. <q>Do you know what\'s reallty real or don\'t
        you?</q> '
    ]
    
    convKeys = 'real-2-node'
    
    eventPercent = 67
    eventReduceTo = 50
    eventReduceAfter = 3
;

+ YesTopic
    "<q>Of course I know what's really real!</q> you tell her. <q>What's really
    real is -- well -- reality!</q>\b
    <q>Isn't that definition ever so slightly circular?</q> the dryad points
    out. <q>The fact of the matter is that reality is a relative concept.</q> 
    <<real2NodeCommon.common>>"
    
    isActive = nodeActive
    convKeys = 'real-2-node'
    
;

+ NoTopic
    "<q>No, I\'m beginning to think perhaps I don\'t,</q> you confess.\b
    <q>Then you are beginning to grow wise,</q> she tells you, with a gently
    approving smile. <q>For indeed, reality is a relative concept.</q> 
    <<real2NodeCommon.common>>"
    
    isActive = nodeActive
    convKeys = 'real-2-node'
    
;

+ SayTopic 'try to define reality'
    "<q>Reality is what's really there,</q> you declare boldly.\b
    <q>Bravo!</q> she cries, clapping her hands together gleefully. <q>A fully
    circular definition! Of course in reality, reality is a purely relative
    concept.</q> <<real2NodeCommon.common>>"
    
    isActive = nodeActive
    convKeys = 'real-2-node'
    includeSayInName = nil
;


+ real2NodeCommon: object
    common = "After a brief pause she continues, <q>Right here and now you are
        real and I am real and all this is real.</q> She indicates the
        surrounding forest with a sweep of her hand. <q>But this is not what
        you might call your primary reality. In your primary reality you're in
        a smoke-filled room overcome with fumes to the point that you're
        hallucinating about meeting a mythological creature in a non-existent
        wood. Does that worry you?</q> <.convnode worry-node>"
    
;

+ DefaultAnyTopic
    "<q>Your attempt to change the subject tells me the answer must be know,</q>
    the dryad interrupts you. <q>You obviously don't know what reality really
    is. How could you? After all, reality is such a relative concept.</q> 
    <<real2NodeCommon.common>>"    
;


+ QueryTopic, StopEventList 'who|what' 'she is; are you'
    [
        '<q>Who are you?</q> you ask.\b
        <q>As I said, I\'m a dryad; a wood-nymph or tree-spirit if you will,</q>
        she replies briskly. <q>I\'m the living essence of this tree. Now,
        perhaps you could answer my question.</q> <.convstay>',
        
        '<q>I am an elemental life force, vitality and fertility, longevity and
        youth,</q> she explains, as if it were all perfectly obvious. <q>But you
        -- you have still not answered my question about reality. Well?</q>
        <.convstay> '
    ]
    
    convKeys = ['real-1-node', 'real-2-node']
    isActive = nodeActive
;

+ YesTopic
    "<q>Yes, it does rather,</q> you confess.\b
    <q>So it should,</q> she tells you, suddenly sombre. <q>You are inhaling
    far too much smoke. If you don't get back there and get yourself away from
    the smoke soon it will be too late; once you're dead there you won't exist
    in any reality!</q> <.reveal smoke>"
    
    convKeys = 'worry-node'
    isActive = nodeActive
;


+ NoTopic
    "<q>No, should it?</q> you reply. <q>After all, if reality is only relative,
    who's to say that what you're telling me is really real, or even what's
    really happening back in my bedroom?</q>\b
    <q>If you die there, you won't exist in any reality,</q> she warns you
    sombrely. <q>You should try to get back before you're completely overcome by
    the smoke and it's too late.</q><.reveal smoke> "
    
    convKeys = 'worry-node'
    isActive = nodeActive
;

+ DefaultAnyTopic
    "<q>No, don't try to change the subject,</q> she stops you. <q>This is
    serious -- deadly serious. Aren't you worried about the smoke overcoming you
    in your primary reality?</q> <.convstay> "
;

+ NodeContinuationTopic, ShuffledEventList
    [
        '<q>Aren\'t you worried about the smoke?</q> the dryad asks you. ',
        '<q>Back in your primary reality you are being overcome by fumes,</q>
        the dryad reminds you. <q>Does that not concern you?</q> ',
        '<q>Your life may depend on taking me seriously,</q> the dryad warns
        you. <q>Did you not hear what I just told you? Does it not worry
        you?</q> '
    ]
    
    eventPercent = 67
    convKeys = 'worry-node'
;


dryadScene: Scene
    startsWhen = (gRevealed('wych'))
    whenStarting()
    {
        dryad.moveInto(glade);
        "The tree suddenly shimmers and, to your astonishment, a slightly
        ghostly figure detaches itself from its trunk and rapidly solidifies
        into the form of a beautiful woman. ";
        dryad.addToAgenda(dryadIntroduction);
    }
    
    endsWhen = gRevealed('smoke')
    
    whenEnding()
    {
        dryad.moveInto(nil);
        "With one last wistful smile the dryad raises her hand in farewell and
        steps back into her tree. A chance gust of wind rustles its leaves
        light a parting sigh, then all falls silent, leaving the glade as if the
        dryad had never been. ";
        scarecrow.addToAgenda(scarecrowGreetingAgenda);
    }
;

dyradDoer: Doer 'go somewhere'
    during = [dryadScene]
    
    execAction(c)
    {
        "You are too fascinated by the dryad to go anywhere right now. ";
    }
    
;

//------------------------------------------------------------------------------


scarecrow: Actor 'scarecrow; poor wretched straw; man sticks' @field
    "It's a poor wretched thing, little more than a couple of sticks stuffed
    with straw wearing a faded brown coat; a straw man if ever there was one! "
    
    
    cannotTakeMsg = 'It\'s a bit too cumbersome to carry around; anyway, the
        crows probably deserve to be scared. '
    
    isHim = true
    isIt = true
;

+ scarecrowInanimateState: ActorState
     specialDesc = "A scarecrow stands guard over the crop at the centre of the
        field, doing his best to ward off <<mention the crows>>. "
    
    remoteSpecialDesc(pov)
    {
        "Off in the distance a scarecrow stands lonely guard over the field. ";
    }
    
    isInitState = true

;

++ DefaultAnyTopic
    "The scarecrow seems a bit too preoccupied with scaring crows to take any 
    notice of you. "   
    
;

+ scarecrowTalkingState: ActorState
    specialDesc = "The scarecrow is staring at you mournfully. "
;

++ AskTellTopic @crows
    "<q>To be honest I never did like crows much,</q> you remark.\b
    <q>Then that's one thing we have in common,</q> he replies. "
;

++ AskTopic @scarecrow
    "<q>Howcome you're talking?</q> you asked. <q>Scarecrows can't talk!</q>\b
    <q>Then what do you call what I'm doing right now?</q> he retorts. <q>You
    obviously need to revise your ideas of reality!</q> "
;

++ DefaultAnyTopic
    "The scarecrow mumbles something unaudible. You suspect its conversational
    abilities are strictly limited. "
;

++ ByeTopic
    "<q>Nice talking to you,</q> the scarecrow sighs, before turning his
    attention back to the ever-annoying crows. "
    
    changeToState = scarecrowInanimateState
;

+ scarecrowGreetingAgenda: ConvAgendaItem
    invokeItem()
    {
        isDone = true;
        getActor.setState(scarecrowTalkingState);
        "<q>You may think this looks like an easy job, just standing here
        scaring crows,</q> the scarecrow remarks suddenly, <q>but I can tell you
        it isn't!</q> ";
    }
;

