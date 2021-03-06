/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement formHelp
    inherits formWindow
    open core, vpiDomains

constants
    className = "formHelp/formHelp".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

% This code is maintained automatically, do not update it manually. 14:03:07-27.4.2010
facts

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("~Информация о кредитовании~"),
        setRect(rct(50,40,346,162)),
        setDecoration(titlebar([closebutton(),minimizebutton()])),
        setBorder(thinBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("\tДобро пожаловать в систему оценки возможности выдачи кредита!\n\n   Банк выдаёт кредиты как физическим, так и юридическим лицам. После рассморения заявки на возможность выдачи кредита, в текстовом окошке выдаётся результат"),
        StaticText_ctl:setPosition(12, 6),
        StaticText_ctl:setSize(272, 108).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement formHelp
