#charset "us-ascii"
#include "advlite.h"

/* 
 *   Possible future modifications to the adv3Lite library, for the time being
 *   kept in a separate mods file for initial development and testing purposes
 */





        
class ListGroup: object
    
;


 /* ------------------------------------------------------------------------ */
/*
 *   Special "debug" action - this simply breaks into the debugger, if the
 *   debugger is present. 
 */



class TopicGroup: object
    
    addToTopic(obj)
    {
        location.addToTopic(obj);
        
        obj.convKeys = convKeys;
        
    }
    
    isActive = true
    convKeys = nil
        
    nodeActive()
    {
        return valToList(convKeys).overlapsWith(getActor.activeKeys);
    }
    
    getActor = (location.getActor)
;