/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/
class formNewClientYur : formNewClientYur
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> formNewClientYur FormNewClientYur.

constructors
    new : (window Parent).

end class formNewClientYur