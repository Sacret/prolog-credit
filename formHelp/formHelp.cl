/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/
class formHelp : formHelp
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> formHelp FormHelp.

constructors
    new : (window Parent).

end class formHelp