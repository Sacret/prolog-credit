/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/
class formNewClientFiz : formNewClientFiz
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> formNewClientFiz FormNewClientFiz.

constructors
    new : (window Parent).

end class formNewClientFiz