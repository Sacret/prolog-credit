/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/
class formClientYur : formClientYur
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> formClientYur FormClientYur.

constructors
    new : (window Parent).

end class formClientYur