/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/
class formDocs : formDocs
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> formDocs FormDocs.

constructors
    new : (window Parent).

end class formDocs