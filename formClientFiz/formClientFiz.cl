/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/
class formClientFiz : formClientFiz
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> formClientFiz FormClientFiz.

constructors
    new : (window Parent).

end class formClientFiz